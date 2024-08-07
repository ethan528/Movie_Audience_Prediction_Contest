mixin HumanResourceManagement {
  void hireEmployeeManagement() {
    print("직원 채용 관리");
  }

  void provideSalaryManagement() {
    print("급여 지급 관리");
  }
}

mixin AccountingManagement {
  void checkAccountingManagement() {
    print("회계 관리");
  }
}

class Employee {
  void currentPosition(bool isManager) {
    if (isManager) {
      print("관리자입니다.");
    } else {
      print("일반 직원입니다.");
    }
  }
}


class Manager extends Employee with HumanResourceManagement, AccountingManagement {
  void manage() {
    hireEmployeeManagement();
    provideSalaryManagement();
    checkAccountingManagement();
  }

  void displayCurrentPosition() {
    currentPosition(true);
  }
}

void main() {
  Manager manager = Manager();
  manager.manage();
  manager.displayCurrentPosition();
}