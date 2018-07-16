# Header file inclusion

# This example demonstrates inclustion of header files.
# A new class 'TwoPlusTwoIsFive' was added to
# demonstrate the concept. It has a header file
# stored in 'include/TwoPlusTwoIsFive.h'
# and a source file in 'src/TwoPlusTwoIsFive.cpp'

### Please note the addition of new varables:
# $(INCDIR) $(INC) and their use. 

# specify compiler to use
CXX := g++-7

### Reorganize project stucture

# source file directory
SRCDIR := src
# include directory with local .h files
INCDIR := include
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
# specify compiler include directives
INC := -I $(INCDIR)

# final executable target
binary: $(TARGET)

# build .o files only for the sake of 
# split build example
objects: $(OBJ)

$(TARGET): $(OBJ)
	$(CXX) -o $(TARGET) $(OBJ)

### NOTE the addition of include flags
# as $(INC) variable at the end of the recepie
$(BUILDDIR)/%.o: $(SRCDIR)/%.cpp
	$(CXX) -o $@ -c $^ $(INC)

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

