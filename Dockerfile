FROM archlinux:base-devel

# makepkg cannot (and should not) be run as root:
RUN useradd -m build && \
    pacman -Syu --noconfirm && \
    pacman -Sy --noconfirm git && \
    # Allow build to run stuff as root (to install dependencies):
    echo "build ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/build

# Continue execution (and CMD) as build:
USER build
WORKDIR /tmp

RUN git clone https://aur.archlinux.org/paru.git && \
    cd paru && \
    makepkg -si --noconfirm

COPY src/* /

# Build the package
CMD ["/bin/bash", "/run.sh"]

