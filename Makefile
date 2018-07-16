# Pattern rules

# As your projects grow larger
# there will be a need to separate the
# build process. For example, while unit testing
# you may want to separate the compilation of
# .cpp files into .o files and linking them
# with unit test libraries into a test runner.
# Pattern rules allow you to to that.
# see line 59

# specify compiler to use
CXX := g++-7

### Reorganize project stucture

# source file directory
SRCDIR := src
# build output directory for .o files
BUILDDIR := build
# build output directory for final executable
BINDIR := bin
# final executable target
TARGET := $(BINDIR)/runme
# list of expected source files
SRCFILES = $(wildcard $(SRCDIR)/*.cpp)
# list of expected object files
OBJ := $(patsubst $(SRCDIR)/%.cpp, $(BUILDDIR)/%.o, $(SRCFILES));


# final executable target
### NOTE: by default make builds the
# first target it finds
binary: $(TARGET)

# build .o files only for the sake of 
# split build example
objects: $(OBJ)

$(TARGET): $(OBJ)
	$(CXX) -o $(TARGET) $(OBJ)

### PATTERN RULE EXAMPLE:
# Pattern rules take form of:
# output_pattern: input_pattern
# <TAB> recepie rules

### NOTE: pattern rules are applied one pattern
# at a time.
#
# $(BUILDDIR)/%.o - match every file in the 'bin'
# directorythat ends with '.o'
#
# $(SRCDIR)/%.cpp - match every file in the 'src'
# directory that ends with '.cpp'
#
# $@ - match every output item
# $^ - match every prerequisite item
$(BUILDDIR)/%.o: $(SRCDIR)/%.cpp
	$(CXX) -o $@ -c $^

# prints list of source files
printSources:
	@echo $(SRCFILES)

# prints list of expected objects
printOjects:
	@echo $(OBJ)


clean: cleanObjects cleanBinary

#deletes object files
cleanObjects:
	@echo removing objects: $(OBJ)
	rm $(OBJ)	

# deletes binary
cleanBinary:
	@echo removing binary: $(TARGET)
	rm $(TARGET)

### IMPORTANT NOTE:
# DO NOT use rules like the one below:
# 'rm -rf $(DIR_NAME)/*'
# If $(DIR_NAME) is no loger a valid variable,
# or make cannot understand it,
# it will interpret the rule as follows:
# "rm -rf /*' which means delete everything
# on your file system.

