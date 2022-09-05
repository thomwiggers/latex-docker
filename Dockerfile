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
        git-lfs \
        minted \
        psutils \
        python \
        bash \
        # https://bugs.archlinux.org/task/75275
        perl-clone \
        # latexindent dependencies
        perl-yaml-tiny \
        perl-file-homedir \
        # https://bugs.archlinux.org/task/75724
        which \
 && rm -rf /var/cache/pacman/pkg/* \
 && luaotfload-tool --update
 
 ENV PATH /usr/bin/vendor_perl:/usr/bin/site_perl:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

