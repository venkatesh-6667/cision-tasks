class Fibonacci:
    def __init__(self):
        self.a = 0
        self.b = 1
        self.sum_even = 0
        self.count = 0

    def generate_next(self):
        self.a, self.b = self.b, self.a + self.b

    def sum_even_fibonacci(self):
        while self.count < 100:
            if self.b % 2 == 0:
                self.sum_even += self.b
                self.count += 1
            self.generate_next()

        return self.sum_even

if __name__ == "__main__":
    fib = Fibonacci()
    result = fib.sum_even_fibonacci()
    print("Sum of the first 100 even Fibonacci numbers:", result)
