create database hotel;
use hotel;
select * from hotel.customer;
select * from hotel.room;
select * from hotel.bookings;
select * from hotel.payments;

# Top 5 Customers by Spending
SELECT c.name, SUM(p.amount) AS total_spent
FROM hotel.payments p
JOIN hotel.customer c ON p.customer_id = c.customer_id
GROUP BY c.name
ORDER BY total_spent DESC
LIMIT 5;

# Average Booking Duration Per Room Type
SELECT r.room_type, AVG(b.no_of_days_booking) AS avg_stay_duration
FROM hotel.bookings b
JOIN hotel.room r ON b.room_no = r.room_no
GROUP BY r.room_type;

# Monthly Revenue Growth
SELECT DATE_FORMAT(payment_date, '%m') AS month, SUM(amount) AS total_revenue
FROM hotel.payments
GROUP BY month
ORDER BY month;

# Trigger for Auto Updating Room Availability
DELIMITER //
CREATE TRIGGER hotel.after_booking_insert
AFTER INSERT ON hotel.bookings
FOR EACH ROW
BEGIN
    UPDATE hotel.room SET availability = 'No' WHERE room_no = NEW.room_no;
END;
//
DELIMITER ;
