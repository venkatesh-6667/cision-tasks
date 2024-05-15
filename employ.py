class Employee:
    def __init__(self, id, name, department, salary):
        self.id = id
        self.name = name
        self.department = department
        self.salary = salary

def extract_employees(file_path):
    employees = []
    with open(file_path, 'r') as file:
        for line in file:
            data = line.strip().split(':')
            employee = Employee(data[0], data[1], data[2], int(data[3]))
            employees.append(employee)
    return employees

def filter_and_sort_employees(employees, department):
    filtered_employees = [emp for emp in employees if emp.department == department]
    sorted_employees = sorted(filtered_employees, key=lambda emp: emp.salary, reverse=True)
    return sorted_employees

def main():
    file_path = 'employees.txt'
    department = 'Engineering'
    
    employees = extract_employees(file_path)
    engineering_employees = filter_and_sort_employees(employees, department)
    
    print("Engineering Department Employees (sorted by salary):")
    for emp in engineering_employees:
        print(f"{emp.name}: ₹{emp.salary}")

if __name__ == "__main__":
    main()
