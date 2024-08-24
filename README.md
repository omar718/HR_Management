# flutter_application_2

GRH-Mobile project developped by Omar Zroud (backend) - Salah ben Hnia (frontend) - Nada Belaid (frontend) for ELITE COUNCIL CONSULTING corporation. 


## Getting Started

This project is a starting point for the GRH Flutter application for ELITE COUNCIL CONSULTING.

## Database schema:

Users Collection

Document ID: Unique user ID (usually the UID from Firebase Authentication).
Fields:
firstName: User's first name.
lastName: User's last name.
email: User's email address.
dateOfBirth:
gender:
nationality:
role: Role of the user (e.g., applicant, employee, admin).
picture: URL to the user's profile picture.
resume: URL to the user's cv file.
appliedJobs: List of job titles the user has applied to.
acceptedJob: The job title where the user is currently employed (if any).
interviewPlanned: interview ID for upcoming interview(if any).
tasks: List of task IDs assigned to the user.


Jobs Collection

Document ID: Unique job ID.
Fields:
title: Title of the job.
description: Detailed description of the job.
requirements: List of job requirements.
location: Job location.
salary: Offered salary for the job.
createdBy: full name of the Admin who posted the job.
adminID: ID of the admin who posted the job.
applicants: List of user IDs who have applied for the job.
acceptedApplicants: User ID of the applicant who was accepted for the job (if any).
status: Status of the job (open, closed.).


Applications Collection

Document ID: Combination of user ID and job ID.
Fields:
userId: ID of the applicant.
adminID: ID of the admin who submitted the job offer.
userName: full name of the applicant.
jobTitle: title of the job applied to.
applicationDate: Date of application submission.
status: Status of the application (pending, accepted, rejected).
interviews: List of interview IDs associated with this application.


Interviews Collection

Document ID: Unique interview ID.
Fields:
jobId: ID of the job for which the interview is scheduled.
userId: ID of the user being interviewed.
interviewDate: Date and time of the interview.
location: Location of the interview.
status: Status of the interview (scheduled, completed, canceled).
outcome: Outcome of the interview for the job (approved,disapproved)
adminId: ID of the admin who scheduled the interview.


Tasks Collection

Document ID: Unique task ID.
Fields:
title: Title of the task.
description: Detailed description of the task.
assignedTo: User ID of the employee assigned to the task.
assignedBy: Admin ID who assigned the task.
dueDate: Due date for task completion.
status: Status of the task (pending, in-progress, completed, overdue).
priority: Priority level of the task (low, medium, high).
createdAt: Timestamp when the task was created.
updatedAt: Timestamp when the task was last updated.


Admins Collection (Optional) => currently not created

Document ID: Unique admin ID.
Fields:
name: Admin's full name.
email: Admin's email address.
managedJobs: List of job IDs managed by the admin.
scheduledInterviews: List of interview IDs for interviews they've scheduled.
assignedTasks: List of task IDs assigned by the admin.


## About the app:
The application offers distinct interfaces for users and administrators, each tailored to their specific roles.

*User Interface:

The user interface includes several essential sections:

- Profile : Allows users to manage and adjust their personal information and upload a profile picture . Additionally, by clicking on the profile photo, users can go back to the home screen or log out.

- Interviews : Displays scheduled interviews with the ability to view detail.

- Tasks : Manages tasks assigned to the user. This section consolidates tasks attributed to the user, facilitating the management of activities to be completed.

*Administrator Interface:

The administrator interface is more robust, integrating advanced features for system management:

- Profile : Allows administrators to customize their information and manage their profile. Similarly, clicking on the profile photo allows administrators to return to the home screen or log out.

- Tasks : Administrators can create and assign tasks, track their progress.

- Interviews : Administrators can prepare interviews.
Administrators can manage the entire recruitment process, including sending job offers and handling applications:

- Applications :Processes job applications submitted by users. The administrator can accept or reject these applications after reviewing the CVs.

- Offers : Allows the administrator to submit job offers that will be displayed on the homepage for users to view.

- Supervise Time : Contains an IoT module for managing candidates' work time.

These interfaces are designed to maximize efficiency by offering smooth navigation and powerful tools for both users and administrators. Additionally, both interfaces allow users to return to the home screen or log out by clicking on the profile photo.


## How it works:


-authentication:(completed)
when a user successfully signs up using firebase auth with an email and password a document will be created in the 'users' collection with these fields initially empty: firstName,lastName,dateOfBirth,gender,picture,resume,appliedJOBS,acceptedJobs,interviewPlanned,tasks
nationality.
in the app we have 4 roles for its users:
guest:user that signed up successfully 
applicant:user that applied to a job
employee:applicant that got accepted for a job
admin

the initial role for the users would be guest and that can change later based on what they'll do.
admins certaintly have access to the database therefore we took a practical and simple approach to having admins and that is by changing the role field from guest to admin in the document of that user in the 'users' collection
the signup process consists of a multi screen signup that will update these initially empty fields if it is completed successfully (firstName,lastName,dateOfBirth,gender,resume,nationality).
the other empty fields gets updated with certain actions taken by the users or admin that we'll get to later


-handling job offers(50% completed)

1st step: submitting the job offers(completed)
admins have their interface (workspace) that will be redirected to when they click on workspace section that appears in the drop down menu when they click on the picture on the right.
when they submit new job offer a new document will be created in the 'jobs' collection, the initial status for any job offer would be 'open' when the admin clicks on the link below that says 'see all your offers' the admin will be redirected to a page that contains all the job offers that he previously submitted fetching the data is from the 'jobs' collection based on the admin ID if it matches the ID of the currently signup user the job offer will appear, with every job offer there is a locker button and a delete button.
the locker button toggles the status of the job offer from open to closed and the delete button deletes the document of the job offer from the collection

2nd step: applying to job offers(completed)
admins can't apply to job offers
when a viewer (no login) clicks on apply now he will get a message telling him to login to be able to apply
when a guest signs up we will check if he provided the important informations (firstName,lastName,resume) when he signed up in case he didn't completed the signup process if that's the case a pop up will appear guiding him to his profile section in the workspace to update those missing info. if he did we will check if he had previously submitted to the same job offer by comparing the document ID with the other documents in the 'applications' collection if yes he will get a message. if not a new document in the 'applications' will be created the inial value of 'status'  for any application will be 'pending' and the 'interviews' field would be empty,the adminID of the admin who submitted the offer will be stored in the 'adminID' field for later purposes.
the values of the 'appliedJobs' and the 'role' fields of the user document will be updated: the user's 'role' changes from guest to applicant.
the 'applicants' field for the job document gets updated.
a message telling the user that he successfully applied for the job appears

3rd step: displaying the applicants
the admins will find in the 'applications' section in their workspace the applicants that successfully applied to their job offers.
fetching the data is from the 'applications' collection to display the specified applications for every admin based on the adminID

4th step:answering to applications
if choosing accept the 'status' field of the 'applications' collection gets upadted to 'accepted' then the applicant name will appear in the list of the 'applicant name' field in the interviews section in the admin workspace, this should fetch from the 'applications' collection where the status of application is 'accepted'. 


-handling interviews:

1st step: submitting interviews(admin):
after the admin enters the interview info, a new document in the interviews collection will be created and initially the 'outcome' value would be empty and 'status' field gets the value of 'scheduled' and the document ID will be stored in 'interviews' field in the the 'applications' collection and since the document ID of an application is a combination of the userID and jobID we add the 'interviewID' based on that. and we also add it to the user document based in the 'interviewPlanned' field based on the userID.
below sould be a link that has 'see all your interviews ' similair to submit offers page, the admin will see all the interviews he has scheduled with the status for each one and he can change the 'outcome' after an interview to 'approved' after a successful interview or 'disapproved' after an ineffective one. a delete button sould be there too.

2nd step: answering interviews(user):
in the interviews section in the user workspace the user should see all his scheduled interviews (if any), the data should be fetched from the 'interviews' collection based on the userID if it should match the ID of the currently connected user.
if the user clicks on accept that updates the 'status' field of the interview document from 'scheduled' to 'accepted' if he clicks on refuse then 'refused' and renewal makes it 'renewed'.

3rd step: setting the outcome:
when the admin clicks on the link 'see all your interviews' he can track the 'status' therefore the response for his interviews if it is 'renewed' the process to a new interview submission will be repeated. if 'refused' he will be able to delete the interview document. if 'accepted' he waits for the interview date and after the interview he upadtes the 'outcome' field to 'approved' or 'disapproved'. if approved that updates 'role' field for the user to document to 'employee' and the 'acceptedJobs' with the 'title' of the job from the 'jobs' collection based on the 'jobID', the 'acceptedApplicants' field from the 'jobs' collection also based on the 'jobID'.


-handling tasks:

1st step: assigning tasks:
in the tasks section in the admin workspace, after submitting all the necesseraly info a new document is added to the 'tasks' collection and the initial value for 'status' field would be 'pending'. 'see all the tasks you assigned ' link sould appear below that redirects the admin the page similair to 'see all your offer' link in the 'submit offer' page. the admin should be able to change the 'status' to 'overdue' or 'completed'.

2nd step: answering to tasks(user):
if the 'role' of the user is 'employee' he should see all his assigned tasks by his admin, this should be fetched from the 'tasks' collection based on his ID. if he accepts that updates the 'status' field of the task document to 'in-progress', that also updates the 'tasks' field in the document from 'users' collection.












