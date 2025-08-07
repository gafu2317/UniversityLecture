CXX = g++
CXXFLAGS = -Wall -std=c++11
TARGET = stack
OBJS = stack.o main.o

$(TARGET): $(OBJS)
	$(CXX) -o $(TARGET) $(OBJS)

stack.o: stack.cpp stack.hpp
	$(CXX) $(CXXFLAGS) -c stack.cpp

main.o: main.cpp stack.hpp
	$(CXX) $(CXXFLAGS) -c main.cpp

clean:
	rm -f $(OBJS) $(TARGET)

.PHONY: clean