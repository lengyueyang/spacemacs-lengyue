# emacs company mode English words auto-compelete

## Description
A lisp file using company-mode to complete english words.
An other version can complete the english words and display the meaning in Chinease.

It defines a words constant list by 'defconst'. 
And define a company backend to complete English words.
It only needs company mode.
Do not require ispell or orther program.

## Useage

Put company-words.el file in a path you like, for example "~/Dropbox/Emacs/".

Add the below command in your .emacs file to load it.

(load "~/Dropbox/Emacs/company-words")

or 

Put company-words-discn.el file in a path you like, for example "~/Dropbox/Emacs/".

Add the below command in your .emacs file to load it.

(load "~/Dropbox/Emacs/company-words-discn")


Then using M-x company-en-words-enable RET, to enable English word company.

Using M-x company-en-words-disable RET, to disable English word company.

You also can using (add-to-list 'company-backends 'company-en-words) in the .emacs after load to enable it in all mode. 

But, this backend will make a lot of other backends cannot work because it match so much imput, so it is not recommended.

## Attached files

English-words.txt: the file includes over 72,000 English words. 
en_cn.txt: the file inlclude voer 24,000 English words with Chinese meaning.
These two files are not required for company mode. Just for reference.

create_company_words.py: a python file to generate the "company-words.el" file from "English-words.txt" file. It is not requried for emacs. Just for reference.
create_company_words-2.py: a python file to generate the "company-words-discn.el" file from "English-words.txt" file. It is not requried for emacs. Just for reference.
