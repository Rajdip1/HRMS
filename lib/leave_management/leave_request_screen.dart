import 'package:flutter/material.dart';

List<LeaveRequest> leaveRequests = [
  LeaveRequest(
    name: "Abhay Kumar",
    profileImage: "assets/abhay.jpg",
    leaveType: "Sick Leave",
    leaveDate: "19 Nov - 19 Nov 2022",
    duration: "1 day(s)",
    leaveBalance: "0 day(s)",
    reason: "High fever",
    appliedDate: "19 Nov 2022",
    status: "pending",
  ),
  LeaveRequest(
    name: "Neha Gupta",
    profileImage: "assets/neha.jpg",
    leaveType: "Unpaid Leave",
    leaveDate: "19 Nov - 19 Nov 2022",
    duration: "1 day(s)",
    leaveBalance: "",
    reason: "Going to village due to urgency",
    appliedDate: "19 Nov 2022",
    status: "pending",
  ),
  LeaveRequest(
    name: "Krupa Patel",
    profileImage: "assets/krupa.jpg",
    leaveType: "Unpaid Leave",
    leaveDate: "19 Nov - 19 Nov 2022",
    duration: "1 day(s)",
    leaveBalance: "0 day(s)",
    reason: "High fever",
    appliedDate: "19 Nov 2022",
    status: "pending",
  ),
  LeaveRequest(
    name: "Rahul Macwan",
    profileImage: "assets/rahul.jpg",
    leaveType: "Urgent Leave",
    leaveDate: "19 Nov - 19 Nov 2022",
    duration: "1 day(s)",
    leaveBalance: "0 day(s)",
    reason: "such as family emergencies",
    appliedDate: "19 Nov 2022",
    status: "pending",
  ),
  LeaveRequest(
    name: "Tiksha Soni",
    profileImage: "assets/tiksha.jpg",
    leaveType: "casual leave ",
    leaveDate: "19 Nov - 19 Nov 2022",
    duration: "1 day(s)",
    leaveBalance: "0 day(s)",
    reason: "Personal work- going to a bank",
    appliedDate: "19 Nov 2022",
    status: "pending",
  ),


];

class LeaveRequestsScreen extends StatefulWidget {
  @override
  _LeaveRequestsScreenState createState() => _LeaveRequestsScreenState();
}

class _LeaveRequestsScreenState extends State<LeaveRequestsScreen> {
  void _updateLeaveStatus(int index, String status) {
    setState(() {
      leaveRequests[index].status = status;
    });
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Leave Requests"),
          bottom: TabBar(
            tabs: [
              Tab(text: "Pending Requests"),
              Tab(text: "History"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            LeaveRequestList(
              leaveRequests: leaveRequests.where((req) => req.status == "pending").toList(),
              onUpdateStatus: _updateLeaveStatus,
            ),
            LeaveRequestList(
              leaveRequests: leaveRequests.where((req) => req.status != "pending").toList(),
              onUpdateStatus: _updateLeaveStatus,
            ),
          ],
        ),

      ),
    );
  }
}

class LeaveRequestList extends StatelessWidget {
  final List<LeaveRequest> leaveRequests;
  final Function(int, String) onUpdateStatus;

  LeaveRequestList({required this.leaveRequests, required this.onUpdateStatus});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("Leave Requests")),
      body: ListView.builder(
        itemCount: leaveRequests.length,
        itemBuilder: (context, index) {
          return LeaveRequestCard(
            leaveRequest: leaveRequests[index],
            onUpdateStatus: (status) => onUpdateStatus(index, status),
          );
        },
      ),
    );
  }
}

class LeaveRequest {
  final String name, profileImage, leaveType, leaveDate, duration, leaveBalance, reason, appliedDate;
  String status;

  LeaveRequest({
    required this.name,
    required this.profileImage,
    required this.leaveType,
    required this.leaveDate,
    required this.duration,
    required this.leaveBalance,
    required this.reason,
    required this.appliedDate,
    required this.status,
  });
}

class LeaveRequestCard extends StatelessWidget {
  final LeaveRequest leaveRequest;
  final Function(String) onUpdateStatus;

  LeaveRequestCard({required this.leaveRequest, required this.onUpdateStatus});

  void _showConfirmationDialog(BuildContext context, String action) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Confirm $action"),
        content: Text("Are you sure you want to $action this leave request?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              onUpdateStatus(action);
              Navigator.pop(context);
            },
            child: Text("Yes"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(leaveRequest.profileImage),
                  onBackgroundImageError: (_, __) => debugPrint("Error loading image"), // Debugging tip
                ),
                SizedBox(width: 10),
              ],
            ),
            Text(leaveRequest.name, style: TextStyle(fontWeight: FontWeight.bold)),
            Text("Applied on: ${leaveRequest.appliedDate}"),
            Text("Leave Type: ${leaveRequest.leaveType}"),
            Text("Duration: ${leaveRequest.duration}"),
            Text("Reason: ${leaveRequest.reason}"),
            SizedBox(height: 10),
            Row(
              children: [
                if (leaveRequest.status == "pending")
                  ElevatedButton(
                    onPressed: () => _showConfirmationDialog(context, "approved"),
                    child: Text("Approve"),
                  ),
                if (leaveRequest.status == "pending")
                  ElevatedButton(
                    onPressed: () => _showConfirmationDialog(context, "rejected"),
                    child: Text("Reject"),
                  ),
                if (leaveRequest.status == "approved")
                  Text("✅ Approved", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                if (leaveRequest.status == "rejected")
                  Text("❌ Rejected", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
