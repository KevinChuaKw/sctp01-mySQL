
create table PetOwners (
id int unsigned auto_increment primary key,
fname varchar(100) not null,
lname varchar(100) not null,
email varchar(320) not null
) engine = innodb;

insert into PetOwners (
    fname, lname, email
) values ("Jason", "Ong", "JO@gmail.com"),("Marcus","Heng","MH@gmail.com"),("Wi","Fi","WF@gmail.com"); 

create table Pets (
id int unsigned auto_increment primary key,
name varchar(50) not null,
PetOwners_id int unsigned not null
) engine = innodb;

alter table Pets add constraint PetOwnership
foreign key (PetOwners_id) references PetOwners(id);

insert into Pets (
    name, PetOwners_id
) values ("Buddy", 1),("Ace",2),("Hunter",3); 


create table Appointments (
id int unsigned auto_increment primary key,
datetime datetime not null,
Vets_id  int unsigned not null,
Pets_id int unsigned not null,
PetOwners_id int unsigned not null
) engine = innodb;

alter table Appointments add constraint ownerAppointment foreign key (PetOwners_id) references PetOwners(id);

alter table Appointments add constraint petsAppointment foreign key (Pets_id) references Pets(id);

alter table Appointments add constraint vetsAppointment foreign key (Vets_id) references Vets(id);


insert into Appointments (
    datetime, Vets_id, Pets_id, PetOwners_id) 
values ("2024-09-08", 1,1,1), ("2024-10-08", 1,2,2),("2024-09-28", 2,3,3);


create table Diagnosis (
id int unsigned auto_increment primary key,
doctor_notes text not null,
Appointment_id int unsigned not null
) engine = innodb;

alter table Diagnosis add constraint vetDiagnosis foreign key (Appointments_id) references Appointments(id);

insert into Diagnosis (
    Doctor_notes, Appointments_id) 
values ("Pet is alive and breathing", 1), ("Pet is still alive and breathing", 1),("Why is this pet still breathing",1);



create table Vets (
    id int unsigned auto_increment primary key,
    first_name varchar(300) not null, 
    last_name varchar(300) not null, 
    office_number varchar(25) not null 
) engine = innodb; 

insert into Vets (
    first_name, last_name, office_number
) values ("John", "Tan", "12345678"),("Kevin","Wong","32323232"),("Big","Dude","98765432"); 


create table Treatments (
id int unsigned auto_increment primary key,
dosage float unsigned not null,
unit varchar(10) not null,
diagnosis_id int unsigned not null,
qty int unsigned not null
) engine = innodb;

alter table Treatments add constraint fk_diagnosis_treatments foreign key (diagnosis_id) references Diagnosis(id);


create table Medicines (
    id int unsigned auto_increment primary key,
    Name varchar(300) not null, 
    Description varchar(300) not null
) engine = innodb; 


insert into Medicines (name, description) values ("amoxicillin", "dog antibiotics");
insert into Medicines (name, description) values ("Rabvac", "Rabies Vaccination");
insert into Medicines (name, description) values ("Carprofen", "Anti Inflammatory PainKiller");

create table Prescription (
    id int unsigned auto_increment primary key,
    Treatment_id int unsigned not null, 
    Medicine_id int unsigned not null
) engine = innodb; 


alter table Prescription add constraint fk_Medicines_Prescription
    foreign key (Medicine_id) references Medicines (id); 

alter table Prescription add constraint fk_Treatments_Prescription
    foreign key (Treatment_id) references Treatments(id);


insert into Treatments (
    dosage, unit, Diagnosis_id, qty) 
values (5,"Thisunit",1,90),(10,"Thisunit",2,25),(75,"Thisunit",1,55); 


create table Shifts (
id int unsigned auto_increment primary key,
day int unsigned not null,
start_time time not null,
end_time time not null,
Vet_id int unsigned not null
) engine = innodb;

alter table Shifts add constraint vetShift foreign key (Vet_id) references Vets(id);

insert into Shifts (
day, start_time, end_time,Vet_id
) value (1, "10:00:00", 12-30-00, 1), (2, 14-00-00, 16-00-00, 3), (1, 08-00-00, 12-00-00, 2); 
