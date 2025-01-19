use [Hotel Booking System (1)];

create table Hotel (
	Hotel_id int primary key,
	HotelName varchar(10),
	HotelLocation varchar(20),
	contact int,
	constraint unique_name unique(HotelName)
)

create table Staff (
 Staff_id int primary key,
 StaffName varchar(10) not null,
 position varchar(10) not null,
 contact int not null,
 Hotel_id int,
 foreign key (Hotel_id) references Hotel(Hotel_id) on DELETE cascade on update cascade
)

create table Guests (
Guest_id int primary key,
GuestName varchar(10) not null,
GuestLocation varchar(20) not null,
contactNo int not null
)

create table Reviews (
review_id int primary key,
rating int not null check(rating between 1 and 5),
comments varchar(250) not null default 'No comments',
review_date date not null,
hotel_id int,
guest_id int,
FOREIGN KEY (hotel_id) REFERENCES Hotel(Hotel_id) on delete cascade on update cascade,
foreign key (guest_id) references Guests(Guest_id) on DELETE cascade on update cascade
)

create table Bookings (
Booking_id int primary key,
guest_id int,
foreign key(guest_id) references Guests(Guest_id) on DELETE cascade on update cascade,
BookingStatus varchar(10),
CONSTRAINT check_booking_status CHECK (BookingStatus IN ('Pending', 'Confirmed', 'Canceled', 'Check-in', 'Check-out')),
Total_cost decimal not null,
check_in_date date not null,
check_out_date date not null,
constraint comparision check(check_in_date<=check_out_date)
)

create table Payment(
Payment_id int primary key,
booking_id int,
guest_id int,
foreign key(booking_id) references Bookings(Booking_id) on DELETE cascade on update cascade,
Payment_date date not null ,
amount decimal not null check (amount > 0),
method varchar(10) not null
)

create table rooms(
room_id int primary key,
booking_id int,
hotel_id int,
foreign key (booking_id) references Bookings(Booking_id) on DELETE cascade on update cascade,
foreign key (hotel_id) references Hotel(Hotel_id) on DELETE cascade on update cascade,
Room_no int not null,
roomType varchar(15),
CONSTRAINT check_room_type CHECK (roomType IN ('Single', 'Double', 'Suite')),
price_per_night decimal check (price_per_night>0),
avail_status bit default 1, 
constraint unique_roomNo unique(Room_no)
)