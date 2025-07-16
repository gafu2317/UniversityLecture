CC = gcc
CFLAGS = -Wall -Wextra -std=c99
COVERAGE_FLAGS = -fprofile-arcs -ftest-coverage
LDFLAGS = --coverage

SRCDIR = .
OBJDIR = build
COVERAGEDIR = coverage

SOURCES = math_functions.c
TEST_SOURCES = test_math_functions.c
OBJECTS = $(SOURCES:.c=.o)
TEST_OBJECTS = $(TEST_SOURCES:.c=.o)

TARGET = test_runner
COVERAGE_TARGET = test_runner_coverage

.PHONY: all clean test coverage coverage-report

all: $(TARGET)

# Normal build
$(TARGET): $(OBJECTS) $(TEST_OBJECTS)
	$(CC) $(CFLAGS) -o $@ $^

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

# Coverage build
$(COVERAGE_TARGET): $(SOURCES) $(TEST_SOURCES)
	$(CC) $(CFLAGS) $(COVERAGE_FLAGS) -o $@ $^ $(LDFLAGS)

# Run tests
test: $(TARGET)
	@echo "Running tests..."
	./$(TARGET)

# Run tests with coverage
coverage: $(COVERAGE_TARGET)
	@echo "Running tests with coverage..."
	./$(COVERAGE_TARGET)

# Generate coverage report
coverage-report: coverage
	@echo "Generating coverage report..."
	@mkdir -p $(COVERAGEDIR)
	gcov test_runner_coverage-math_functions.gcda
	@echo ""
	@echo "=== Coverage Summary ==="
	@for file in *.gcov; do \
		if [ -f "$$file" ]; then \
			echo "Coverage for $$file:"; \
			head -5 "$$file"; \
			echo ""; \
		fi \
	done
	@echo "Coverage files generated:"
	@ls -la *.gcov *.gcda *.gcno 2>/dev/null || echo "No coverage files found"

# Generate HTML coverage report (requires lcov)
coverage-html: coverage
	@echo "Generating HTML coverage report..."
	@mkdir -p $(COVERAGEDIR)
	lcov --capture --directory . --output-file $(COVERAGEDIR)/coverage.info
	genhtml $(COVERAGEDIR)/coverage.info --output-directory $(COVERAGEDIR)/html
	@echo "HTML coverage report generated in $(COVERAGEDIR)/html/"

clean:
	rm -f $(TARGET) $(COVERAGE_TARGET) *.o *.gcov *.gcda *.gcno
	rm -rf $(COVERAGEDIR)

# Help
help:
	@echo "Available targets:"
	@echo "  all            - Build test runner"
	@echo "  test           - Run tests"
	@echo "  coverage       - Run tests with coverage"
	@echo "  coverage-report - Generate coverage report"
	@echo "  coverage-html  - Generate HTML coverage report (requires lcov)"
	@echo "  clean          - Clean build files"
	@echo "  help           - Show this help message"