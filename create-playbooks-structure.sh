#!/bin/sh

print_usage() {
    echo "Usage:"
    echo "  Create a top level structure: 'create_ansible_structure.sh [TOP_DIRECTORY_PATH]'"
    echo "  Create a role structure:      'create_ansible_structure.sh role [TOP_DIRECTORY_PATH] [ROLE_NAME]'"
}

error() {
    echo "Error: ${1}"
    print_usage
    exit 1
}

create_directory() {
    if [ -e $1 -a ! -d $1 ]; then
        error "Required directory '${1}' already exists as a file."
    fi

    if [ ! -e $1 ]; then
        mkdir $1
        echo "Create a directory: ${1}"
    fi

    if [ $# -ge 2 ]; then
        if [ $2 = "gitkeep" ]; then
            if [ ! -e "${1}/.gitkeep" ]; then
                touch "${1}/.gitkeep"
            fi
        fi
    fi
}

create_file() {
    if [ ! -e $1 ]; then
        touch $1
        echo "Create a file:      ${1}"
    fi
}

create_toplevel_structure() {
    create_directory $1
    create_directory "${1}/group_vars"     "gitkeep"
    create_directory "${1}/host_vars"      "gitkeep"
    create_directory "${1}/library"        "gitkeep"
    create_directory "${1}/filter_plugins" "gitkeep"
    create_directory "${1}/roles"          "gitkeep"
    create_file "${1}/production"
    create_file "${1}/stage"
    create_file "${1}/development"
    create_file "${1}/site.yml"
}

create_role_structure() {
    if [ ! -e $1 ]; then
        error "Top level directory '${1}' does not exists."
    fi

    if [ ! -d $1 ]; then
        error "Top level directory '${1}' is not a directory."
    fi

    roledir="${1}/roles/${2}"

    create_directory "${1}/roles"
    create_directory $roledir
    create_directory "${roledir}/tasks"             "gitkeep"
    create_file      "${roledir}/tasks/main.yml"
    create_directory "${roledir}/handlers"          "gitkeep"
    create_directory "${roledir}/vars"              "gitkeep"
    create_directory "${roledir}/defaults"          "gitkeep"
    create_directory "${roledir}/meta"              "gitkeep"
    create_directory "${roledir}/library"           "gitkeep"
    create_directory "${roledir}/files"             "gitkeep"
    create_directory "${roledir}/templates"         "gitkeep"
}

if [ $# -lt 1 ]; then
    error "Missing arguments."
fi

if [ $# -eq 1 ]; then
    if [ $1 = "-h" ]; then
        print_usage
        exit 0
    fi

    create_toplevel_structure $1
elif [ $# -eq 3 ]; then
    if [ $1 != "role" ]; then
        error "Invalid arguments."
    fi

    create_role_structure $2 $3
else
    error "Invalid arguments."
fi

exit 0
