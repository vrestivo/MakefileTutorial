# Lets start with basics

### Implicit variables are built-in variables.
# They are used to configure GNU Make behavior
# or to specify default values.

### NOTE ":=" means the variable is ready for use
# immediately after assignment.

# Lets set a default compiler by using 'CXX'
# implicit variable:
CXX := g++-7

# We can also use user-defined variables
# for our own purposes.

# Lets create a variable for the final executable
# we want to produce.
TARGET := runme # later refered to as $(TARGET)

# A Makefile rule constists of a target, dependencies, and recepies.
# Take a look at line 37
#
# '$(TARGET):' specifies the end product ('runme' executable)
# 'main.o' is the required input for the target

### NOTE: there is no target for 'main.o'!
# make has implicit (built-in) rules, which rely on file naming
# coventions to figure out how to build 'main.o',
# In our case make will look for main.cpp
# and will compile it on its own to produce 'main.o'

# The recepie specification takes the following form:
# '<TAB>$(CXX) -o $(TARGET) main.o'
# which will translated into 'g++-7 -o runme main.o'
### NOTE: every recepie line must start with a TAB
(TARGET): main.o
	$(CXX) -o $(TARGET) main.o

