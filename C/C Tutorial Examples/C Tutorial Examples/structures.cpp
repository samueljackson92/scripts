struct database {
	int id;
	int age;
	float salary;
}

struct database returnEmployee();

int main (){
	struct database emp;
	emp = returnEmployee();

}

struct database returnEmployee() {
	struct database employee; //create a new strcuture
	employee.id = 12;
	employee.age = 42;
	employee.salary = 12020.50;

	return employee;
}