import 'dart:io';

enum RequestStatus { pending, inProgress, resolved }

class ServiceRequest {
  final int id;
  final String studentName;
  final String studentId; // Added to store the student's ID number
  final String category;
  final String description;
  RequestStatus status;
  
  ServiceRequest({
    required this.id,
    required this.studentName,
    required this.studentId,
    required this.category,
    required this.description,
    this.status = RequestStatus.pending,
  });
}

final List<ServiceRequest> requests = [
  ServiceRequest(
    id: 1001,
    studentName: 'Student Demo',
    studentId: 'CB26001',
    category: 'IT Support',
    description: 'Cannot connect to the campus Wi-Fi.',
  ),
  ServiceRequest(
    id: 1002,
    studentName: 'Student Demo',
    studentId: 'CB26002',
    category: 'Maintenance',
    description: 'Classroom projector is not working.',
    status: RequestStatus.inProgress,
  ),
];

int nextId = 1003;

String readRequired(String prompt) {
  while (true) {
    stdout.write(prompt);
    final value = stdin.readLineSync()?.trim() ?? '';
    if (value.isNotEmpty) return value;
    print('Input cannot be empty. Please try again.');
  }
}

String statusText(RequestStatus status) {
  switch (status) {
    case RequestStatus.pending:
      return 'Pending';
    case RequestStatus.inProgress:
      return 'In Progress';
    case RequestStatus.resolved:
      return 'Resolved';
  }
}

void submitRequest() {
  print('\n--- SUBMIT SERVICE REQUEST ---');
  final name = readRequired('Student name: ');
  final stuId = readRequired('Student ID number: '); // New authentication step
  
  // Numbered option selection for categories
  print('\nSelect Category:');
  print('1. IT Support');
  print('2. Maintenance');
  print('3. Library');
  print('4. Security');
  print('5. Other');
  
  String category = '';
  while (category.isEmpty) {
    final choice = readRequired('Select an option (1-5): ');
    switch (choice) {
      case '1':
        category = 'IT Support';
        break;
      case '2':
        category = 'Maintenance';
        break;
      case '3':
        category = 'Library';
        break;
      case '4':
        category = 'Security';
        break;
      case '5':
        category = 'Other';
        break;
      default:
        print('Invalid option. Please select 1-5.');
    }
  }
  
  final description = readRequired('\nDescribe the problem: ');
  
  requests.add(
    ServiceRequest(
      id: nextId++,
      studentName: name,
      studentId: stuId,
      category: category,
      description: description,
    ),
  );
  print('\nRequest submitted successfully.');
  print('Your request ID is: ${requests.last.id}');
}

void listRequests() {
  print('\n--- ALL SERVICE REQUESTS ---');
  if (requests.isEmpty) {
    print('No requests have been recorded.');
    return;
  }
  for (final r in requests) {
    print(
      '#${r.id} | ${r.studentName} (${r.studentId}) | ${r.category} | '
      '${statusText(r.status)}',
    );
    print('   ${r.description}');
  }
}

void searchRequest() {
  print('\n--- SEARCH REQUEST ---');
  final idText = readRequired('Enter request ID: ');
  final id = int.tryParse(idText);
  if (id == null) {
    print('Invalid request ID. Please enter numbers only.');
    return;
  }
  final matches = requests.where((r) => r.id == id).toList();
  if (matches.isEmpty) {
    print('No request found with ID $id.');
    return;
  }
  final r = matches.first;
  print('ID: ${r.id}');
  print('Student Name: ${r.studentName}');
  print('Student ID: ${r.studentId}');
  print('Category: ${r.category}');
  print('Description: ${r.description}');
  print('Status: ${statusText(r.status)}');
}

void updateStatus() {
  print('\n--- UPDATE REQUEST STATUS ---');
  final idText = readRequired('Request ID: ');
  final id = int.tryParse(idText);
  if (id == null) {
    print('Invalid request ID.');
    return;
  }
  final request = requests.cast<ServiceRequest?>().firstWhere(
    (r) => r?.id == id,
    orElse: () => null,
  );
  if (request == null) {
    print('No request found with ID $id.');
    return;
  }
  print('1. Pending');
  print('2. In Progress');
  print('3. Resolved');
  final choice = readRequired('Select new status: ');
  switch (choice) {
    case '1':
      request.status = RequestStatus.pending;
      break;
    case '2':
      request.status = RequestStatus.inProgress;
      break;
    case '3':
      request.status = RequestStatus.resolved;
      break;
    default:
      print('Invalid status option.');
      return;
  }
  print('Request #$id updated to ${statusText(request.status)}.');
}

void showSummary() {
  final pending = requests.where((r) => r.status == RequestStatus.pending).length;
  final inProgress = requests.where((r) => r.status == RequestStatus.inProgress).length;
  final resolved = requests.where((r) => r.status == RequestStatus.resolved).length;
  
  print('\n--- REQUEST SUMMARY ---');
  print('Total requests : ${requests.length}');
  print('Pending        : $pending');
  print('In Progress    : $inProgress');
  print('Resolved       : $resolved');
}

void main() {
  while (true) {
    print('\n==========================================');
    print(' CAMPUS SERVICE REQUEST MANAGEMENT SYSTEM');
    print('==========================================');
    print('1. Submit service request');
    print('2. View all requests');
    print('3. Search request by ID');
    print('4. Update request status');
    print('5. View summary');
    print('0. Exit');
    final choice = readRequired('Select an option: ');
    switch (choice) {
      case '1':
        submitRequest();
        break;
      case '2':
        listRequests();
        break;
      case '3':
        searchRequest();
        break;
      case '4':
        updateStatus();
        break;
      case '5':
        showSummary();
        break;
      case '0':
        print('Thank you. System closed.');
        return;
      default:
        print('Invalid option. Please select 0-5.');
    }
  }
}
