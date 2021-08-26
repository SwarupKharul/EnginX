# Setting term colors
bold=$(tput bold)
underline=$(tput sgr 0 1)
reset=$(tput sgr0)
purple=$(tput setaf 171)
red=$(tput setaf 1)
green=$(tput setaf 76)
tan=$(tput setaf 3)
blue=$(tput setaf 38)

# Setting up loggers
e_header() {
    printf "\n${bold}${tan}==========  %s  ==========${reset}\n\n" "$@"
}
e_shameless_plug() {
    printf "➜ $@\n${reset}"
}
e_arrow() {
    printf "  ➜ $@\n"
}
e_success() {
    printf "${green}✔ %s${reset}\n" "$@"
}
e_error() {
    printf "${red}✖ %s${reset}\n" "$@"
}
e_warning() {
    printf "${tan}➜ %s${reset}\n" "$@"
}
e_underline() {
    printf "${underline}${bold}%s${reset}\n" "$@"
}
e_heading() {
    printf "${underline}${bold}${blue}${reset}${blue}%s${reset}\n" "$@"
}