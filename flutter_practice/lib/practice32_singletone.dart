class Singleton {
  // 싱글톤 클래스에 담을 변수
  static final Map<String, dynamic> _data = <String, dynamic>{};

  // 생성자를 private로 제한하기 위해 선언
  static final Singleton _singletonData = Singleton._internal();

  // 단일 인스턴스를 리턴하기 위해 factory 사용
  factory Singleton() => _singletonData;

  // 인스턴스를 생성하여 실행을 위한 코드를 여기에 삽입
  Singleton._internal() {
    print("싱글톤 클래스의 인스턴스가 생성되었습니다.");
  }

  // setter와 getter 메소드 추가
  set(String key, dynamic data) => _data[key] = data;
  get(String key) => _data[key];
}

void main() {
  Singleton dataList1 = Singleton();
  dataList1.set('Job1', 'Student');
  dataList1.set('Name1', 'Andrew');

  Singleton dataList2 = Singleton();
  dataList2.set('Job2', 'Developer');
  dataList2.set('Name2', 'Paul');

  if (dataList1 == dataList2) {
    print("같은 인스턴스입니다.");
  }

  print("dataList1 정보");
  print("Job1: ${dataList1.get('Job1')}, Name1: ${dataList1.get('Name1')}");
  print("Job2: ${dataList1.get('Job2')}, Name2: ${dataList1.get('Name2')}");

  print("dataList2 정보");
  print("Job1: ${dataList2.get('Job1')}, Name1: ${dataList2.get('Name1')}");
  print("Job2: ${dataList2.get('Job2')}, Name2: ${dataList2.get('Name2')}");
}
