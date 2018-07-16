# Unit test build Example

# This example demonstrates integration of 
# Google Test framework and creation of test
# targets.
# Google Test dependencies (header files
# and static libraries) are located in the
# 'gtest' directory.

### NOTE: build targets which exclude main.cpp
# and main.o were added in order to maintain
# code modularity for unit testing purposes 

# specify compiler to use
CXX := g++-7


################################################
### MAIN PROGRAM DIRECTORY STRUCTURE-RELATED ###
################################################
# main base name
MAINBASE := main
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
SRCFILES := $(wildcard $(SRCDIR)/*.cpp)
# list of expected object files
OBJ := $(patsubst $(SRCDIR)/%.cpp, $(BUILDDIR)/%.o, $(SRCFILES))
# specify compiler include directives
INC := -I $(INCDIR)
# filter out main for unit testing
MAINOBJ := $(BUILDDIR)/$(MAINBASE).o
MAINSRC := $(SRCDIR)/$(MAINBASE).cpp
SRCNOMAIN := $(filter-out $(MAINSRC), $(SRCFILES)) 
OBJNOMAIN := $(filter-out $(MAINOBJ), $(OBJ)) 



########################################
### TEST DIRECTORY STRUCTURE-RELATED ###
########################################
TESTDIR := test
TESTSRCDIR := $(TESTDIR)/src
TESTBUILDDIR := $(TESTDIR)/build
TESTBINDIR := $(TESTDIR)/bin
TESTRUNNER := $(TESTBINDIR)/runner
TESTSRCFILES := $(wildcard $(TESTSRCDIR)/*.cpp)
TESTOBJ := $(patsubst $(TESTSRCDIR)/%.cpp, $(TESTBUILDDIR)/%.o, $(TESTSRCFILES))
TESTINC := -I gtest/include $(INC)
TESTLINK := -L gtest/lib -lgtest -pthread



####################################
### MAIN PROGRAM-RELATED TARGETS ###
####################################
#Final executable target
binary: $(TARGET)

$(TARGET): $(OBJ)
	$(CXX) -o $(TARGET) $(OBJ)

### NOTE: the addition of include flags
# as $(INC) variable at the end of the recepie
$(BUILDDIR)/%.o: $(SRCDIR)/%.cpp
	$(CXX) -o $@ -c $^ $(INC)



############################
### TEST-RELATED TARGETS ###
############################
test: buildObjectsNoMain $(TESTOBJ)
	$(CXX) -o $(TESTRUNNER) $(TESTOBJ) $(OBJNOMAIN) $(TESTLINK)

$(TESTBUILDDIR)/%.o: $(TESTSRCDIR)/%.cpp
	$(CXX) -o $@ -c $^ $(TESTINC)


### NOTE how $(call) function is used
# to call a user-defined $(buildProgObject) function 
buildObjectsNoMain:
	@echo building objects excluding main.o
	$(foreach source, $(SRCNOMAIN), $(call buildProgObject, $(source)))

# function to build program objects one at at time
define buildProgObject
	$(eval src := $(notdir $1))
	@echo compiling $(src)
	$(CXX) -o $(BUILDDIR)/$(src:.cpp=.o) -c $(SRCDIR)/$(src) $(INC)

endef



###########################
### DEBUG PRINT TARGETS ###
###########################
# prints list of source files
printSources:
	@echo $(SRCFILES)

# prints list of expected objects
printOjects:
	@echo $(OBJ)

printTestSources:
	@echo $(TESTSRCFILES)



#####################
### CLEAN TARGETS ###
#####################
clean: cleanObjects cleanBinary testClean

#deletes object files
cleanObjects:
	@echo removing objects: $(OBJ)
	rm $(OBJ)	

# deletes binary
cleanBinary:
	@echo removing binary: $(TARGET)
	rm $(TARGET)

testClean: cleanTestObjects cleanTestRunner

# deletes test pbjects
cleanTestObjects:
	@echo removing test objects:
	rm $(TESTOBJ)

# deletes test binary
cleanTestRunner:
	@echo removing test runner:
	rm $(TESTRUNNER)


