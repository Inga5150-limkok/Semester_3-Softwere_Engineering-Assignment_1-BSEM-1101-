# Campus Service Request Management System (CSRMS)

A console-based Dart prototype developed for **PROG 202 – Software Engineering (Assignment 1)** at **Limkokwing University of Creative Technology**. 

This system establishes a structured, traceable request-management workflow to capture, search, monitor, and update campus operational problems (such as Wi-Fi failures, faulty equipment, and library requests). It replaces fragmented informal reporting channels with reliable software engineering patterns.

---

## 🚀 Key Features

*   **Strict Numeric Student Validation:** Collects student names and enforces an explicit numeric constraint on **Student ID inputs (integers)**. The system rejects alphabetic strings and words instantly to prevent faulty data entries.
*   **Menu-Driven Categorization:** Replaces unpredictable free-text typing with an error-free numbered selection grid:
    1. IT Support
    2. Maintenance
    3. Library
    4. Security
    5. Other
*   **Automated ID Tracking:** Auto-generates an incremental, unique reference ID for every submitted ticket (starting at `1003`) to ensure high operational traceability.
*   **Dynamic Data Querying:** Allows support operators to isolate and view full ticket logs instantly by entering a numeric request ID.
*   **State Machine Life Cycle:** Features status update controls allowing personnel to transition active tickets across explicit `Pending`, `In Progress`, and `Resolved` states.
*   **Management Workload Summaries:** Computes exact live monitoring metrics indicating the total volume of submissions alongside status counts.
*   **Crash-Proof Reliability:** Utilizes cyclic validation loops (`readRequired` and `int.tryParse`) ensuring that empty spaces or invalid entries never throw unhandled runtime exceptions.

---

## 🛠️ System Architecture & Logic

The prototype architecture relies cleanly on core object-oriented principles:
*   **Data Structure (`ServiceRequest`):** A custom object model maintaining structural components: `id` (int), `studentName` (String), `studentId` (int), `category` (String), `description` (String), and `status` (`RequestStatus`).
*   **State Constraints (`RequestStatus`):** An automated `enum` object capturing explicit states (`pending`, `inProgress`, `resolved`) to completely remove typos from systemic operations.
*   **In-Memory Storage:** Records are temporarily structured into a high-performance global collection array list (`List<ServiceRequest>`), serving as the structural blueprint before setting up cloud-persistent layers.

---

## 💻 Getting Started

### Prerequisites
Make sure you have the official Dart SDK running on your development machine. You can verify your environment setup using:
```bash
dart --version
```
If you need to install it, visit the [Dart SDK Setup Portal](https://dart.dev).

### Setup and Execution

1. Clone or download this project's code directory file to your workspace:
   ```bash
   git clone https://github.com
   cd campus-service-request-system
   ```

2. Run the console application instantly using your native machine terminal environment:
   ```bash
   dart run campus_service_request_system.dart
   ```

---

## 📊 Live Sample Console Run

```text
==========================================
 CAMPUS SERVICE REQUEST MANAGEMENT SYSTEM
==========================================
1. Submit service request
2. View all requests
3. Search request by ID
4. Update request status
5. View summary
0. Exit
Select an option: 1

--- SUBMIT SERVICE REQUEST ---
Student name: Johnson
Student ID number (numbers only): ABCD
Invalid Student ID. Please enter numbers only, no letters.
Student ID number (numbers only): 20260942

Select Category:
1. IT Support
2. Maintenance
3. Library
4. Security
5. Other
Select an option (1-5): 3

Describe the problem: Core Engineering textbooks are missing from the reference aisle.

Request submitted successfully.
Your request ID is: 1003
```

---

## 🔮 Roadmap & Future Development (Assignment 2)

This console prototype implements the foundational logic requested by the assignment brief. Future development deliverables will include:
1.  **UI/UX Migration:** Converting terminal menus into a clean, responsive mobile frontend layout built on **Flutter**.
2.  **Persistent Storage:** Transitioning volatile local-memory list arrays over to structured cloud tables using **Supabase Database Engine**.
3.  **Advanced Capabilities:** Adding role-based user logins, multimedia attachments (uploading image evidence of faults), tracking timestamps, and automated push alerts.
