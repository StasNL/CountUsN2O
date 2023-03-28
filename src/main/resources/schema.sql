DROP TABLE IF EXISTS genders CASCADE;
DROP TABLE IF EXISTS subjects CASCADE;

CREATE TABLE IF NOT EXISTS classes
(
    cl_id      SERIAL4 PRIMARY KEY,
    study_year INT NOT NULL,
    mnemocode  VARCHAR(32)
);

CREATE TABLE IF NOT EXISTS subjects
(
    sub_id       SERIAL4 PRIMARY KEY,
    subject_name VARCHAR(32) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS genders
(
    gen_id      SERIAL4 PRIMARY KEY,
    gender_name VARCHAR(20) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS students
(
    st_id      SERIAL4 PRIMARY KEY,
    name       VARCHAR(32) NOT NULL,
    surname    VARCHAR(32) NOT NULL,
    patronymic VARCHAR(32) NOT NULL,
    birth_year INT         NOT NULL,
    gender_id  INT         NOT NULL,
    class_id   BIGINT,

    CONSTRAINT fk_students_to_classes FOREIGN KEY (class_id) REFERENCES classes (cl_id)
        ON DELETE SET NULL ON UPDATE SET NULL,
    CONSTRAINT fk_students_to_genders FOREIGN KEY (gender_id) REFERENCES genders (gen_id)
);

CREATE TABLE IF NOT EXISTS teachers
(
    teach_id   SERIAL4 PRIMARY KEY,
    surname    VARCHAR(32) NOT NULL,
    name       VARCHAR(32) NOT NULL,
    patronymic VARCHAR(32) NOT NULL,
    birth_year INT         NOT NULL,
    gender_id  INT         NOT NULL,
    subject_id INT         NOT NULL,
    class_id   BIGINT,

    CONSTRAINT fk_teachers_to_classes FOREIGN KEY (class_id) REFERENCES classes (cl_id)
        ON DELETE SET NULL ON UPDATE SET NULL,
    CONSTRAINT fk_teachers_to_genders FOREIGN KEY (gender_id) REFERENCES genders (gen_id),
    CONSTRAINT fk_teachers_to_subjects FOREIGN KEY (subject_id) REFERENCES subjects (sub_id)
);