#!/bin/bash

# Capture the current directory
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

# Update package list
sudo apt-get update

# Install Python 3.11 and pip
sudo apt-get install -y python3.11 python3-pip python3.11-venv

# Create a directory for the project
mkdir browser_chat_project
cd browser_chat_project

# Create a virtual environment
python3.11 -m venv venv

# Activate the virtual environment
source venv/bin/activate

# Install pip packages
pip install --break-system-packages langchain_openai playwright dotenv

# Install Playwright browsers
playwright install
playwright install-deps

# Create the browser-chat.py script
cat <<EOF > browser-chat.py
import os
import asyncio
import argparse
from langchain_openai import ChatOpenAI
from dotenv import load_dotenv
from browser_use import Agent, Browser
from browser_use.browser.context import BrowserContext

# Reuse existing browser
browser = Browser()
context = BrowserContext(browser=browser)

async def close():
    await browser.close()

async def main(task, output_file):
    agent = Agent(
        task=task,
        llm=ChatOpenAI(model="gpt-4o"),
        browser_context=context,
    )
    await agent.run()
    if output_file:
        with open(output_file, 'a') as f:
            f.write(f"You: {task}\n")
            f.write(f"Agent: {await agent.get_response()}\n")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Browser Chat App")
    parser.add_argument('--file', help='File to store the conversation (optional)')
    parser.add_argument('initial_message', nargs='?', help='Initial message to start the chat')
    args = parser.parse_args()

    print("Welcome to the Browser Chat App!")
    print("Type 'exit' to quit.")
    
    if args.initial_message:
        print(f"You: {args.initial_message}")
        asyncio.run(main(args.initial_message, args.file))
    
    while True:
        user_input = input("You: ")
        if not user_input or user_input.lower() == "exit":
            print("Exiting the chat app.")
            break
        # Run the agent with user input
        asyncio.run(main(user_input, args.file))
    asyncio.run(close())
EOF

# Deactivate the virtual environment
deactivate

# Create the wrapper script in /usr/bin
sudo nano /usr/bin/browser_chat

# Add the following content to the script
cat <<EOF | sudo tee /usr/bin/browser_chat > /dev/null
#!/bin/bash

# Check if --help option is provided
if [[ "$1" == "--help" ]]; then
    echo "Usage: browser_chat [options] [initial_message]"
    echo "Options:"
    echo "  --file <filename>  File to store the conversation (optional)"
    echo "  --help             Show this help message and exit"
    echo "Initial Message:"
    echo "  An optional initial message to start the chat."
    exit 0
fi

# Determine the directory of the script
SCRIPT_DIR=\$(cd "\$(dirname "\${BASH_SOURCE[0]}")" && pwd)

# Set the working directory to the project directory
PROJECT_DIR="$SCRIPT_DIR"
cd "\$PROJECT_DIR"

# Construct the command
COMMAND="python3 \${PROJECT_DIR}/browser-chat.py"

# Add --file option if provided
if [[ "\$1" == "--file" ]]; then
    COMMAND="\$COMMAND --file \$2"
    shift 2
fi

# Add initial message if provided
if [[ -n "\$1" ]]; then
    COMMAND="\$COMMAND \"\$1\""
fi

# Execute the command
eval "\$COMMAND"
EOF

# Make the script executable
sudo chmod +x /usr/bin/browser_chat

# Explanation of how to invoke the new command
echo "The browser_chat command has been installed. Here are some usage examples:"
echo "1. Basic usage:"
echo "   browser_chat"
echo "2. With initial message:"
echo "   browser_chat \"Hello, how are you?\""
echo "3. With file option:"
echo "   browser_chat --file conversation.log"
echo "4. With both file and initial message:"
echo "   browser_chat --file conversation.log \"Hello, how are you?\""
echo "5. Help option:"
echo "   browser_chat --help"
