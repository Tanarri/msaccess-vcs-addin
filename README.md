Version Control System (msaccess-vcs-integration)
======================
*for Microsoft Access Database Development*
----------

About
-----

Easily export your Microsoft Access Database objects for use with a version control system like **GitHub** or **GitLab**. (Allows you to track code changes over time, and even collaborate with other developers on the same project.)

This project works as a **Microsoft Access add-in**, allowing you to click a menu item to export the objects and source code from the currently open Microsoft Access Database.

![Export-All](img/gui-demo.gif)

Development Focus
-----------------
This project is used internally to manage the development of numerous Microsoft Access databases, some of which are very complex with hundreds of components. The focus of this development branch is primarily in the following areas:
* **Intuitive user interface** for managing code exports and related options, instead of having to set all these options in code or remember commands to run in the immediate window.
* **Optimal performance**, even with very complex databases. This is largely achieved through the Fast Save option which only exports the changed files. Most databases can be exported in a few seconds or less.
* **Extensive support** for different types of database components beyond the standard database objects. See [Supported Objects](https://github.com/joyfullservice/msaccess-vcs-integration/wiki/Supported-Objects) for more details on what can be exported from a database.
* **Code quality** - I am doing my best to continually refine and organize the code into efficient and well commented logical flows. This is a work in progress, but I feel it is critical to the long-term success of the project.
* **ADP Project** support. While this is an outdated technology, there are some of us that still support and maintain complex ADP projects. This tool has been extended to export objects from ADP projects, including server-side SQL object details.

Installation
---------
 Simply download the add-in from the [**Releases**](https://github.com/joyfullservice/msaccess-vcs-integration/releases) page, and run the file. It will install or update the add-in for you. Additional notes on installation can be found on the [project wiki](https://github.com/joyfullservice/msaccess-vcs-integration/wiki/Installation). 

Contributing
------------
Interested in adding a feature or fixing a bug? [Issues](https://github.com/joyfullservice/msaccess-vcs-integration/issues) and [pull requests](https://github.com/joyfullservice/msaccess-vcs-integration/pulls) are welcome for this project. [This page](/CONTRIBUTING.md) describes some guidelines and the types of contributions would be most helpful.

Development Roadmap
-------------------
Since there are several forks of this project on GitHub, I thought it might be helpful to give some insight into the long-term direction I am taking with this fork. Below are some of the changes I am looking to implement in the future:
 
* Finish out the *Build from Source* functionality so that a database can be fully built (as much as possible) exclusively from source files. This will also allow us to more easily utilize pull requests and code merges on GitHub using the standard Github workflow. (The binary *.accdb file is treated more like a compiled release, rather than working source code.)

* Continue to improve and refactor the code base for better long-term maintenance and extensibility. For example, using a class interface to implement consistent import/export functions among the various types of objects and data contained in the Microsoft Access database.

* Implement some type of automated testing where a complex sample database can be exported, reconstructed, exported again, and compared with the original export to ensure that the build process is fully constructing the database from the exported source files.

Related Projects
----------------
This project was originally forked from [timabell/msaccess-vcs-integration](https://github.com/timabell/msaccess-vcs-integration).

The following forks and projects may also be of interest:
* [pmidhdev/msaccess-vcs-integration](https://github.com/pmidhdev/msaccess-vcs-integration/)
* [hecon5/msaccess-vcs-integration](https://github.com/hecon5/msaccess-vcs-integration)
* [SaltyCybernaut/msaccess-vcs-integration](https://github.com/SaltyCybernaut/msaccess-vcs-integration)
* [A9G-Data-Droid/AccessDB-BuildFromSource](https://github.com/A9G-Data-Droid/AccessDB-BuildFromSource)

