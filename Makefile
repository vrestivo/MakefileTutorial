# Pattern matching and clean targets

CXX := g++-7
TARGET := runme # later refered to as $(TARGET)

# When working on a larget project, 
# one can expect multiple target prerequisites.
# Specifying them by file name can be tedious,
# error-prone, and plain silly since files can
# be renamed at any time.

# We can use pattern matching functions
# to specify multiple input requirements
# and avoid issues listed above.

# Functions in make take the following form
# $(function_name argument1, argument2, agumentN)

# lets specify expected source files using
# pattern matching 'wildcard' function
# this function will match all files ending with
# '.cpp' in current directory
SRCFILES = $(wildcard *.cpp)


# 'patsubst' function takes the following form:
# $(patsubst pattern, replacement, input_variable)
# '%' is a wildcard used to match a pattern.
# Lets use 'patsubst' function to specify required
# .o object files to build the final binary
OBJ := $(patsubst %.cpp, %.o, $(SRCFILES));

(TARGET): $(OBJ)
	$(CXX) -o $(TARGET) $(OBJ)

# prints list of source files
printSources:
	@echo $(SRCFILES)

# prints list of expected objects
printOjects:
	@echo $(OBJ)


# deletes all build outputs
clean:
	@echo removing objects: $(OBJ)
	@echo removing binary: $(TARGET)
	rm $(OBJ)	
	rm $(TARGET)

### IMPORTANT NOTE:
# DO NOT use rules like the one below:
# 'rm -rf $(DIR_NAME)/*'
# If $(DIR_NAME) is no loger a valid variable,
# or make cannot understand it,
# it will interpret the rule as follows:
# "rm -rf /*' which means delete everything
# on your file system.

