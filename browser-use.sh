#!/bin/bash

# Update package list
sudo apt-get update

# Install Python 3.11 and pip
sudo apt-get install -y python3.11 python3-pip

# Create a directory for the project
mkdir browser_chat_project
cd browser_chat_project

# Create a virtual environment
python3.11 -m venv venv

# Activate the virtual environment
source venv/bin/activate

# Install pip packages
pip install --break-system-packag browser-use langchain_openai playwright dotenv

# Install Playwright browsers
playwright install

# Create the browser-chat.py script
cat <<EOF > browser-chat.py
import os
import asyncio
from langchain_openai import ChatOpenAI
from browser_use import Agent
from dotenv import load_dotenv

async def main(task):
    agent = Agent(
        task=task,
        llm=ChatOpenAI(model="gpt-4o"),
    )
    await agent.run()

if __name__ == "__main__":
    
    print("Welcome to the Browser Chat App!")
    print("Type 'exit' to quit.")
    
    while True:
        user_input = input("You: ")
        if not user_input or user_input.lower() == "exit":
            print("Exiting the chat app.")
            break
        
        # Run the agent with user input
        asyncio.run(main(user_input))
EOF

# Run the script
python3 browser-chat.py

# Deactivate the virtual environment
deactivate
