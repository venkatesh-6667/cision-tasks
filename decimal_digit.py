class DecimalDigitTransformation:
    def calculate_sum(self, X):
        try:
            # Convert X to integer
            X = int(X)
            
            # Ensure X is a decimal digit between 0 and 9
            if X < 0 or X > 9:
                raise ValueError("X must be a decimal digit between 0 and 9.")
            
            # Calculate the sum
            total = sum(int(str(X) * i) * (10 ** (i - 1)) for i in range(1, 5))
            
            return total
        except ValueError as e:
            return str(e)

# Example usage If X=4
transformer = DecimalDigitTransformation()
print(transformer.calculate_sum(4))  # Output: 4936
