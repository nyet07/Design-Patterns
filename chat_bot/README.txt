CS342 Design Patterns
Fall 2015
PROJECT 2 README FILE

Due Date: OCT 23, 2015 
Submission Date: 10/14/2015
Author(s): Ugur Buyukdurak

PURPOSE:
It is a Artifical Intelligence simulation program that tries to match given words
with data stored in a file and act accordingly

PERCENT COMPLETE:
I have completed pretty much everything for the assignment.

PARTS THAT ARE NOT COMPLETE:
Non

BUGS:
No bugs.

FILES:
chat.rb
chatter.txt
driver.rb
read_file.rb
README.txt
script.txt
user.rb

SAMPLE OUTPUT:
Hello, my name is Tom
Hello, what’s your name?
My name is ?
How are you?
I cant complain. How about you?
Is that because you are a computer?
That's a pretty good reason if I do say so myself.
I like this conversation.
I do to. Why do you like it?
How does that make you feel?
I took a vow not to reveal how it is done.
...
...
...
...


TO RUN:
Just run the driver.rb file. If you wanna see data structures used in the application,
you can also run read_file.rb file.

EXTRA CREDIT:
I have used lambda functions for strategy pattern.
I also encapsulated different logics within Proc objects.

BIBLIOGRAPHY:
Non.

MISCELLANEOUS:

There is Template Pattern relationship between Chat and ChatBot classes. 
Template Method is "startChatBot" method declared inside Chat class. 
"processResponse" and "chooseStrategy" methods are abstract methods declared within Chat class. 

"chooseStrategy" method chooses appropriate "Strategy" for the corresponding response. These "Strategies" are defined as lambda functions to be returned
form "chooseStrategy" method to "processResponse" method. "processResponse" method calls "strategy" returned from chooseStrategy function.
The main idea is to make modular algorithms that can be used or changed during run-time.
There are also proc objects declared. Those are used for separating logic from each other.

There is subject-observer relationship between User and ChatBot classes. User is the subject and ChatBot is the observer. 
All classes derived from Chat class has "update" method. 
"startDialogue" method of User class constantly updates its observers using "notify_observers" built-in function of "Observable" module.
"update" function of observers is called through "notify_observers" function of the "Observable" module included in the subject class of User.
"add_observer" built-in function of "Observable" module is used for adding observers to the framework. So observers can get modified. 




