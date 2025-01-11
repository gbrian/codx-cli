IDEA_VERSION=2023.1
IDEA_BUILD=2023.1.2
idea_local_dir=~/.IdeaIC${IDEA_VERSION}
TARGETARCH=$(uname -m)
if [ "$TARGETARCH" = "aarch64" ]; then 
    idea_arch='-aarch64'
else 
    idea_arch='' 
fi

mkdir -p ~/opt/idea

echo "Preparing IntelliJ IDEA ${IDEA_BUILD} ..."
echo "Architecture: ${TARGETARCH}"
idea_source=https://download.jetbrains.com/idea/ideaIC-${IDEA_BUILD}${idea_arch}.tar.gz
echo "Downloading ${idea_source} ..."
curl -fsSL $idea_source -o ~/opt/idea/installer.tgz
tar --strip-components=1 -xzf ~/opt/idea/installer.tgz -C ~/opt/idea
