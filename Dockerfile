FROM archlinux:latest

RUN pacman -Syu --noconfirm \
 && pacman -S --noconfirm \
        texlive-most \
        texlive-lang \
        texlive-bibtexextra \
        biber \
        t1utils \
        ghostscript \
        psutils \
        bash \
 && rm -rf /var/cache/pacman/pkg/*

