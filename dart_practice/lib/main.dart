void main() {
  print("="*100);
  print("Dart Practice");
  print("="*100);

  print("Hello World");

  demonstrateVariables();
  demonstrateIntegers();
  demonstrateDoubles();
  demonstrateBooleans();
  demonstrateStrings();
  demonstrateVar();
  demonstrateDynamic();
  demonstrateNullSafety();
  demonstrateFinalConst();
  demonstrateOperations();
  demonstrateList();
  demonstrateMap();
  demonstrateSet();
  demonstrateIfAndSwitch();
  demonstrateLoops();
  demonstrateEnum();
  demonstrateFunction();
}

void demonstrateVariables() {
  print("="*100);
  print("demonstrateVariables");
  print("="*100);

  // Variable
  var name = "name1";
  print(name);
  var name2 = "name2";
  print(name2);
  name = "Dart";
  print(name);

  // A variable can only be declared once within the same scope.
  // var name = "Hello World";
}

void demonstrateIntegers() {
  print("="*100);
  print("demonstrateIntegers");
  print("="*100);

  // Integer
  int number1 = 10;
  print(number1);
  int number2 = 15;
  print(number2);
  int number3 = -20;
  print(number3);

  int number4 = 2;
  int number5 = 4;
  print(number4 + number5);
  print(number4 - number5);
  print(number4 / number5);
  print(number4 * number5);
}

void demonstrateDoubles() {
  print("="*100);
  print("demonstrateDoubles");
  print("="*100);

  // Double
  double number1 = 2.5;
  double number2 = 0.5;
  print(number1 + number2);
  print(number1 - number2);
  print(number1 / number2);
  print(number1 * number2);
}

void demonstrateBooleans() {
  print("="*100);
  print("demonstrateBooleans");
  print("="*100);

  // Boolean
  bool isTrue = true;
  bool isFalse = false;
  print(isTrue);
  print(isFalse);
}

void demonstrateStrings() {
  print("="*100);
  print("demonstrateStrings");
  print("="*100);

  // String
  String name1 = "name1";
  String name2 = "name2";
  print(name1);
  print(name2);
}

void demonstrateVar() {
  print("="*100);
  print("demonstrateVar");
  print("="*100);

  // Var String
  var name1 = "name1";
  var number1 = 20;
  // 'var' infers the type based on the assigned value.
  print(name1.runtimeType);

  // Use 'var' when the type is complex and inference is needed.
  // For clarity, use explicit types when the type is simple.
  Map<String, Map<int, List<double>>> test = {};
  var testType = {};

  String name2 = "name2";
  String name3 = "name3";
  print(name2 + name3);
  print(name2 + " " + name3);

  // Use curly braces `{}` for complex expressions or when accessing properties.
  print("${name2.runtimeType} ${name3}");
  // Without `{}`, only simple variables or literals are interpreted.
  print("$name2.runtimeType $name3");
}

void demonstrateDynamic() {
  print("="*100);
  print("demonstrateDynamic");
  print("="*100);

  dynamic name1 = "Dynamic";
  print(name1);
  dynamic number1 = 1;
  print(number1);

  var name2 = "name2";
  print(name2);

  print(name1.runtimeType);
  print(name2.runtimeType);

  // With 'dynamic', the type can change at runtime.
  // This allows reassigning a different type of value, as shown here.
  // With 'var', the type is inferred from the initial assignment and is fixed.
  // Reassigning a different type is not allowed, so only values of the same type as the initial assignment are permitted.
  name1 = 2;
  // name2 = 2;
}

void demonstrateNullSafety() {
  print("="*100);
  print("demonstrateNullSafety");
  print("="*100);

  // Nullable - Can hold a null value.
  // Non-nullable - Cannot hold a null value.
  // Null - Represents the absence of a value.
  String name1 = "name1";
  print(name1);

  // name = null;
  // The '?' indicates that the variable can be null.
  String? name2 = "name2";
  name2 = null;
  print(name2);

  // The '!' operator is used to assert that 'name2' is not null.
  // This will throw a runtime exception if 'name2' is actually null at this point.
  // print(name2!);
}

void demonstrateFinalConst() {
  print("="*100);
  print("demonstrateFinalConst");
  print("="*100);

  final String name1 = "final";
  // Declare a final variable without an explicit type (like var)
  // final name1 = "final"

  // const String name2 = "const";
  // Declare a const variable without an explicit type (like var)
  const name2 = "const";

  print(name1);
  print(name2);

  // The final variable 'name1' can only be set once.
  // name1 = "final2";
  // Const variables can't be assigned a value after they are initialized.
  // name2 = "const2";

  // This is allowed because final variables can be set at runtime.
  final DateTime now = DateTime.now();
  print(now);

  // This will cause an error because const variables must be set at compile time.
  // DateTime.now() can only be determined at runtime.
  // const DateTime now2 = DateTime.now();
}

void demonstrateOperations() {
  print("="*100);
  print("demonstrateOperations");
  print("="*100);

  int number1 = 2;

  print(number1);
  print(number1 + 2);
  print(number1 - 2);
  print(number1 * 2);
  print(number1 / 2);


  // The remainder operator (%) returns the remainder of the division.
  print(number1 % 2);
  print(number1 % 3);
  print(number1);

  // All of the following operations actually change the value of the variable.
  number1++;
  print(number1);
  number1--;
  print(number1);

  double number2 = 4.0;
  print(number2);
  number2 += 1;
  print(number2);
  number2 -= 1;
  print(number2);
  number2 *= 2;
  print(number2);
  number2 /= 2;
  print(number2);


  double? number3 = 4.0;
  print(number3);
  number3 = 2.0;
  print(number3);
  number3 = null;
  print(number3);

  // The ??= operator checks if the variable on its left is null.
  // If it is null, it assigns the value on its right to the variable.
  // If it is not null, it does nothing.
  number3 ??= 3.0;
  print(number3);


  // Comparison operators to compare number4 and number5
  int number4 = 1;
  int number5 = 2;
  print(number4 > number5);
  print(number4 < number5);
  print(number4 >= number5);
  print(number4 <= number5);
  print(number4 == number5);
  print(number4 != number5);

  // Type test operators to check the type of number6
  int number6 = 1;
  print(number6 is int);
  print(number6 is String);
  print(number6 is! int);
  print(number6 is! String);

  // Logical AND (&&) checks if both conditions are true.
  // If both conditions are true, the result is true.
  bool result = 12 > 10 && 1 > 0;
  print(result);
  bool result2 = 12 > 10 && 0 > 1;
  print(result2);

  // Logical OR (||) checks if at least one of the conditions is true.
  // If at least one condition is true, the result is true.
  bool result3 = 12 > 10 || 1 > 0;
  print(result3);
  bool result4 = 12 > 10 || 0 > 1;
  print(result4);
  bool result5 = 12 < 10 || 0 > 1;
  print(result5);
}

void demonstrateList() {
  print("="*100);
  print("demonstrateList");
  print("="*100);
  // List
  // The angle brackets <> are used to specify the type of elements in the list.
  List<String> stringList = ["string1", "string2", "string3"];
  List<int> intList = [1, 2, 3];
  print(stringList);
  print(intList);

  // Index
  // Index starts from zero and must be within the range of the list length.
  print(stringList[0]);
  print(stringList[1]);

  print(stringList.length);
  stringList.add("string4");
  print(stringList);
  stringList.remove("string4");
  print(stringList);
  print(stringList.indexOf("string2"));
}

void demonstrateMap() {
  print("="*100);
  print("demonstrateMap");
  print("="*100);

  // Map
  // A Map is a collection of key-value pairs.
  // The types for both keys and values in the Map must be specified using generics.
  Map<String, String> dictionary = {
    "key1": "value1",
    "key2": "value2",
    "key3": "value3",
  };
  print(dictionary);

  Map<String, bool> isDictionary = {
    "key1": true,
    "key2": true,
    "key3": false,
  };
  print(isDictionary);

  isDictionary.addAll({
    "key4": false,
  });
  print(isDictionary);

  print(isDictionary["key2"]);

  isDictionary["key5"] = false;
  print(isDictionary);

  isDictionary["key1"] = false;
  print(isDictionary);

  print(isDictionary);
  isDictionary.remove("key1");
  print(isDictionary);

  print(isDictionary.keys);
  print(isDictionary.values);
}

void demonstrateSet() {
  print("="*100);
  print("demonstrateSet");
  print("="*100);

  // Set
  // A Set is a collection of unique items.
  // It does not allow duplicate values.
  // Sets must be defined with generics to specify the type of items they hold.
  final Set<String> names = {
    "name1",
    "name2",
    "name3",
    "name2",
  };
  print(names);

  names.add("name4");
  print(names);
  names.remove("name4");
  print(names);

  print(names.contains("name2"));
}

void demonstrateIfAndSwitch() {
  print("="*100);
  print("demonstrateIfAndSwitch");
  print("="*100);

  // If
  // The 'if' statement executes a block of code if the condition is true.
  // If the condition is false, it can optionally execute a different block of code.
  int number = 2;

  if (number % 3 == 0) {
    print("The remainder is 0");
  } else if (number % 3 == 1) {
    print("The remainder is 1");
  } else {
    print("The remainder is 2");
  }

  // Switch
  // The 'switch' statement selects a block of code
  // to execute based on the value of an expression.
  // Each 'case' represents a value to compare to the expression.
  // If a match is found, the corresponding block of code executes.
  switch (number % 3) {
    case 0:
      print("The remainder is 0");
      break;

    case 1:
      print("The remainder is 1");
      break;

    default:
      print("The remainder is 2");
      break;
  }
}

void demonstrateLoops() {
  print("="*100);
  print("demonstrateLoops");
  print("="*100);

  // For loop
  // The 'for' loop is used to repeat a block of code a known number of times.
  // It consists of three parts: initialization, condition, and increment.
  // Initialization: int i = 0; - This sets the starting value of the loop variable 'i'.
  // Condition: i < 10; - The loop continues as long as this condition is true.
  // Increment: i++ - This increases the loop variable 'i' by 1 after each iteration.
  for (int i = 0; i < 10; i++) {
    print(i);
  }

  int total = 0;
  List<int> numbers = [1, 2, 3, 4, 5, 6];
  for (int i = 0; i < numbers.length; i++) {
    total += numbers[i];
  }
  print(total);

  // The 'for-in' loop iterates over each element in a collection.
  // In this example, it iterates through the list 'numbers'.
  // For each iteration, 'number' represents the current element.
  total = 0;
  for(int number in numbers) {
    print(number);
    total += number;
  }
  print(total);

  // While loop
  // The 'while' loop repeatedly executes a block of code
  // as long as its condition evaluates to true.
  total = 0;
  while (total < 10) {
    total += 1;
  }
  print(total);

  // The 'do-while' loop executes a block of code once,
  // and then repeats the loop as long as the condition is true.
  total = 0;
  do {
    total += 1;
  } while (total < 10);
  print(total);


  // The 'break' statement is used to exit the loop when a specific condition is met.
  total = 0;
  while (total < 10) {
    total += 1;

    if (total == 5) {
      break;
    }
  }
  print(total);
  total = 0;
  for (int i = 0; i < 10; i++) {
    total += 1;

    if (total == 5) {
      break;
    }
  }
  print(total);

  // The 'continue' statement skips the current iteration when a specific condition is met.
  for (int i = 0; i < 10; i++) {
    if (i == 5) {
      continue;
    }
    print(i);
  }
}

// An enum (short for enumeration) is a type that defines a set of named values.
// It can make your code more readable and less error-prone.
enum Status {
  approved,
  pending,
  rejected,
}

void demonstrateEnum() {
  print("="*100);
  print("demonstrateEnum");
  print("="*100);

  Status status = Status.approved;

  if (status == Status.approved) {
    print("Approved");
  } else if (status == Status.pending) {
    print("Pending");
  } else {
    print("Rejected");
  }
}

// Positional Parameters: These are parameters that are specified by their
// position in the parameter list.

// Optional Parameters: These can be either positional or named.
// Optional positional parameters are enclosed in square brackets [ ],
// and optional named parameters are enclosed in curly braces { }.
// They are not required and can have default values.

// Named Parameters: These are parameters that are specified by their name
// in the function call. Named parameters can be required or optional.

// The return type specifies the data type of the value
// that the function will return. It is declared before
// the function name and helps to understand what type
// of data the function will output.

// A function that adds three numbers (x, y, z) and tells whether the sum is even or odd.
int addNumbers(int x, {required int y, int z = 30}) {
  int sum = x + y + z;

  print("x: $x");
  print("y: $y");
  print("z: $z");

  if (sum % 2 == 0) {
    print("The number is even");
  } else {
    print("The number is odd");
  }

  return sum;
}

// Arrow Function: An arrow function is a shorthand syntax for writing a function.
// It is used for concise, one-line functions. The syntax uses '=>' followed by the expression.
// The expression's value is returned by the function.
int addNumbers2(int x, {required int y, int z = 30}) => x + y + z;

void demonstrateFunction() {
  print("="*100);
  print("demonstrateEnum");
  print("="*100);

  int result1 = addNumbers(10, y: 20);
  int result2 = addNumbers2(10, y: 30, z: 40);
  print("result1: $result1");
  print("result2: $result2");
  print("sum: ${result1 + result2}");
}

// Typedef: The 'typedef' keyword is used to create a custom, reusable function type alias.
// This helps in making the code more readable and maintainable.
typedef Operation = int Function(int x, int y, int z);

int add(int x, int y, int z) => x + y + z;

int subtract(int x, int y, int z) => x - y - z;

int calculate(int x, int y, int z, Operation operation) {
  return operation(x, y, z);
}

void demonstrateTypedef() {
  print("="*100);
  print("demonstrateTypedef");
  print("="*100);

  Operation operation = add;

  int result = operation(10, 20, 30);
  print(result);

  operation = subtract;

  int result2 = operation(10, 20, 30);
  print(result2);

  int result3 = calculate(30, 40, 50, add);
  print(result3);

  int result4 = calculate(40, 50, 60, subtract);
  print(result4);
}