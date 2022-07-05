FROM archlinux:latest

RUN pacman -Syu --noconfirm \
 && pacman -S --noconfirm \
        make \
        texlive-most \
        texlive-lang \
        texlive-bibtexextra \
        biber \
        t1utils \
        ghostscript \
        git \
        psutils \
        python \
        bash \
        # latexindent dependencies
        perl-yaml-tiny \
        perl-file-homedir \
 && rm -rf /var/cache/pacman/pkg/* \
 && luaotfload-tool --update

