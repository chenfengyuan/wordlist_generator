uname_M := $(shell sh -c 'uname -m 2>/dev/null || echo not')
uname_S := $(shell sh -c 'uname -s 2>/dev/null || echo not')
CXXFLAGS = -O2 -std=c++11
LDLIBS = -lboost_regex-mt -lboost_system-mt
ifeq ($(uname_S),Darwin)
CC = clang
CXX = clang++
endif

ifeq ($(uname_S),Linux)
CC = gcc
CXX = g++
endif

-include $(OBJS:.o=.d)
-include destruct-test.Makefile

%.o: %.c
	$(CC) -c $(CFLAGS) $*.c -o $*.o
	$(CC) -MM -MP $(CFLAGS) $*.c > $*.d
%.o: %.cpp
	$(CXX) -c $(CXXFLAGS) $*.cpp -o $*.o
	$(CXX) -MM -MP $(CXXFLAGS) $*.cpp > $*.d
%.o: %.cc
	$(CXX) -c $(CXXFLAGS) $*.cc -o $*.o
	$(CXX) -MM -MP $(CXXFLAGS) $*.cc > $*.d
%.out: %.cc
	$(CXX) $(CXXFLAGS) $*.cc -o $*.out $(LDLIBS)
	$(CXX) -MM -MP $(CXXFLAGS) $*.cc > $*.d
all:wordlist_generator.out
.PHONY:clean
clean:
	rm -f *.o *.s *.i $(ELFS) *.d *.out