CC = gcc
CFLAGS = -Wall -lm
OBJ = main15-1.o task15-1.o
EXEC = task15-1

all: $(EXEC)

$(EXEC): $(OBJ)
	$(CC) $(CFLAGS) -o $(EXEC) $(OBJ)

main15-1.o: main15-1.c task15-1.h
	$(CC) $(CFLAGS) -c main15-1.c

task15-1.o: task15-1.c task15-1.h
	$(CC) $(CFLAGS) -c task15-1.c



# CC = gcc
# CFLAGS = -Wall -g
# OBJ = main14.o task14.o
# TARGET = task14

# all: $(TARGET)

# $(TARGET): $(OBJ)
# 	$(CC) $(CFLAGS) -o $(TARGET) $(OBJ)

# main14.o: main14.c task14.h
# 	$(CC) $(CFLAGS) -c main14.c

# task14.o: task14.c task14.h
# 	$(CC) $(CFLAGS) -c task14.c

# clean:
# 	rm -f $(OBJ) $(TARGET)
gcc -c main15-1.c
gcc -c task15-1.c
gcc -o task15-1 main15-1.o task15-1.o -lm
