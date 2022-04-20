-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

SET SQL_SAFE_UPDATES = 0;
DROP DATABASE IF EXISTS Multimedia_Content_Management_DB;
CREATE DATABASE Multimedia_Content_Management_DB;
USE Multimedia_Content_Management_DB;



-- -----------------------------------------------------
-- Schema mydb_trial1
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Table `generaluser`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `generaluser` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(255) NOT NULL,
  `guest_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mailing_list`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mailing_list` (
  `mailing_id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(255) NOT NULL,
  `description` VARCHAR(255) NULL,
  PRIMARY KEY (`mailing_id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mailing_list_users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mailing_list_users` (
  `generaluser_user_id` INT NOT NULL,
  `mailing_list_mailing_id` INT NOT NULL,
  PRIMARY KEY (`generaluser_user_id`, `mailing_list_mailing_id`),
  INDEX `fk_mailing_list_users_mailing_list_idx` (`mailing_list_mailing_id` ASC) VISIBLE,
  CONSTRAINT `fk_mailing_list_users_generaluser1`
    FOREIGN KEY (`generaluser_user_id`)
    REFERENCES `generaluser` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_mailing_list_users_mailing_list1`
    FOREIGN KEY (`mailing_list_mailing_id`)
    REFERENCES `mailing_list` (`mailing_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `messaging_list`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `messaging_list` (
  `messaging_id` INT NOT NULL AUTO_INCREMENT,
  `phone_number` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NULL,
  PRIMARY KEY (`messaging_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `generaluser_has_messaging_list`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `generaluser_has_messaging_list` (
  `generaluser_user_id` INT NOT NULL,
  `messaging_list_messaging_id` INT NOT NULL,
  PRIMARY KEY (`generaluser_user_id`, `messaging_list_messaging_id`),
  INDEX `fk_generaluser_has_messaging_list_generaluser1_idx` (`generaluser_user_id` ASC) VISIBLE,
  INDEX `fk_generaluser_has_messaging_list_messaging_list1_idx` (`messaging_list_messaging_id` ASC) VISIBLE,
  CONSTRAINT `fk_generaluser_has_messaging_list_generaluser1`
    FOREIGN KEY (`generaluser_user_id`)
    REFERENCES `generaluser` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_generaluser_has_messaging_list_messaging_list1`
    FOREIGN KEY (`messaging_list_messaging_id`)
    REFERENCES `messaging_list` (`messaging_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `devices`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `devices` (
  `device_id` INT NOT NULL,
  `device_ip` VARCHAR(45) NULL,
  `account_id` INT NULL,
  PRIMARY KEY (`device_id`),
  UNIQUE INDEX `device_id_UNIQUE` (`device_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `has_logged_from`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `has_logged_from` (
  `is_ip_validated` TINYINT(1) NULL DEFAULT NULL,
  `devices_device_id` INT NOT NULL,
  PRIMARY KEY (`devices_device_id`),
  CONSTRAINT `fk_has_logged_from_devices1`
    FOREIGN KEY (`devices_device_id`)
    REFERENCES `devices` (`device_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `registereduser`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `registereduser` (
  `registered_user_id` INT NOT NULL,
  `r_name` VARCHAR(45) NULL,
  `admin_registereduser_registered_user_id` INT NULL,
  `generaluser_user_id` INT NOT NULL,
  `has_logged_from_devices_device_id` INT NULL,
  PRIMARY KEY (`registered_user_id`, `generaluser_user_id`),
  INDEX `fk_registereduser_admin1_idx` (`admin_registereduser_registered_user_id` ASC) VISIBLE,
  INDEX `fk_registereduser_generaluser1_idx` (`generaluser_user_id` ASC) VISIBLE,
  INDEX `fk_registereduser_has_logged_from1_idx` (`has_logged_from_devices_device_id` ASC) VISIBLE,
  CONSTRAINT `fk_registereduser_admin1`
    FOREIGN KEY (`admin_registereduser_registered_user_id`)
    REFERENCES `admin` (`registereduser_registered_user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_registereduser_generaluser1`
    FOREIGN KEY (`generaluser_user_id`)
    REFERENCES `generaluser` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_registereduser_has_logged_from1`
    FOREIGN KEY (`has_logged_from_devices_device_id`)
    REFERENCES `has_logged_from` (`devices_device_id`)
    ON DELETE SET NULL
    ON UPDATE SET NULL)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `admin`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `admin` (
  `admin_id` INT NOT NULL AUTO_INCREMENT,
  `permission_id` VARCHAR(45) NOT NULL,
  `admin_name` VARCHAR(45) NULL,
  `registereduser_registered_user_id` INT NOT NULL,
  `generaluser_user_id` INT NOT NULL,
  PRIMARY KEY (`admin_id`, `registereduser_registered_user_id`, `generaluser_user_id`),
  INDEX `fk_admin_registereduser1_idx` (`registereduser_registered_user_id` ASC) VISIBLE,
  INDEX `fk_admin_generaluser1_idx` (`generaluser_user_id` ASC) VISIBLE,
  CONSTRAINT `fk_admin_registereduser1`
    FOREIGN KEY (`registereduser_registered_user_id`)
    REFERENCES `registereduser` (`registered_user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_admin_generaluser1`
    FOREIGN KEY (`generaluser_user_id`)
    REFERENCES `generaluser` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `region`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `region` (
  `region_id` INT NOT NULL,
  `region_name` VARCHAR(45) NOT NULL,
  `device_id` INT NOT NULL,
  `country_code` VARCHAR(45) NOT NULL,
  `cdn_id` INT NOT NULL,
  PRIMARY KEY (`region_id`),
  UNIQUE INDEX `device_id_UNIQUE` (`device_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `account`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `account` (
  `account_id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `user_password` VARCHAR(45) NOT NULL,
  `expires_on` DATE NOT NULL,
  `region_region_id` INT NOT NULL,
  `generaluser_user_id` INT NOT NULL,
  PRIMARY KEY (`account_id`, `generaluser_user_id`, `region_region_id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE,
  INDEX `fk_account_region1_idx` (`region_region_id` ASC) VISIBLE,
  INDEX `fk_account_generaluser1_idx` (`generaluser_user_id` ASC) VISIBLE,
  CONSTRAINT `fk_account_region1`
    FOREIGN KEY (`region_region_id`)
    REFERENCES `region` (`region_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_account_generaluser1`
    FOREIGN KEY (`generaluser_user_id`)
    REFERENCES `generaluser` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `role` (
  `role_id` INT NOT NULL,
  `description` VARCHAR(45) NULL,
  `permission_number` INT NULL,
  `admin_id` INT NULL,
  PRIMARY KEY (`role_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `account_has_role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `account_has_role` (
  `account_account_id` INT NOT NULL,
  `role_role_id` INT NOT NULL,
  PRIMARY KEY (`account_account_id`, `role_role_id`),
  INDEX `fk_account_has_role_account1_idx` (`account_account_id` ASC) VISIBLE,
  INDEX `fk_account_has_role_role1_idx` (`role_role_id` ASC) VISIBLE,
  CONSTRAINT `fk_account_has_role_account1`
    FOREIGN KEY (`account_account_id`)
    REFERENCES `account` (`account_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_account_has_role_role1`
    FOREIGN KEY (`role_role_id`)
    REFERENCES `role` (`role_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Basic`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Basic` (
  `basic_id` INT NOT NULL AUTO_INCREMENT,
  `account_account_id` INT NOT NULL,
  `role_id` INT NOT NULL,
  PRIMARY KEY (`basic_id`, `account_account_id`),
  INDEX `fk_Basic_account1_idx` (`account_account_id` ASC) VISIBLE,
  CONSTRAINT `fk_Basic_account1`
    FOREIGN KEY (`account_account_id`)
    REFERENCES `account` (`account_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `premium`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `premium` (
  `premium_id` INT NOT NULL AUTO_INCREMENT,
  `role_id` INT NOT NULL,
  `account_account_id` INT NOT NULL,
  PRIMARY KEY (`premium_id`, `account_account_id`),
  INDEX `fk_premium_account1_idx` (`account_account_id` ASC) VISIBLE,
  CONSTRAINT `fk_premium_account1`
    FOREIGN KEY (`account_account_id`)
    REFERENCES `account` (`account_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `advertisements`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `advertisements` (
  `advertisement_id` INT NOT NULL,
  `advertisement_name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NULL,
  PRIMARY KEY (`advertisement_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `advertisements_linked_to`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `advertisements_linked_to` (
  `Basic_basic_id` INT NOT NULL,
  `advertisements_advertisement_id` INT NOT NULL,
  PRIMARY KEY (`Basic_basic_id`, `advertisements_advertisement_id`),
  INDEX `fk_Basic_has_advertisements_advertisements1_idx` (`advertisements_advertisement_id` ASC) VISIBLE,
  CONSTRAINT `fk_Basic_has_advertisements_Basic1`
    FOREIGN KEY (`Basic_basic_id`)
    REFERENCES `Basic` (`basic_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Basic_has_advertisements_advertisements1`
    FOREIGN KEY (`advertisements_advertisement_id`)
    REFERENCES `advertisements` (`advertisement_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `promotions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `promotions` (
  `promotion_id` INT UNSIGNED NOT NULL,
  `description` VARCHAR(45) NULL,
  `promotion_type` VARCHAR(45) NULL,
  `promotion_title` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`promotion_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `organization`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `organization` (
  `organization_id` INT NOT NULL,
  `organization_name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NULL,
  `organization_contact_num` VARCHAR(45) NULL,
  PRIMARY KEY (`organization_id`),
  UNIQUE INDEX `organization_id_UNIQUE` (`organization_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `advertisements_has_promotions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `advertisements_has_promotions` (
  `advertisements_advertisement_id` INT NOT NULL,
  `promotions_promotion_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`advertisements_advertisement_id`, `promotions_promotion_id`),
  INDEX `fk_advertisements_has_promotions_promotions1_idx` (`promotions_promotion_id` ASC) VISIBLE,
  INDEX `fk_advertisements_has_promotions_advertisements1_idx` (`advertisements_advertisement_id` ASC) VISIBLE,
  CONSTRAINT `fk_advertisements_has_promotions_advertisements1`
    FOREIGN KEY (`advertisements_advertisement_id`)
    REFERENCES `advertisements` (`advertisement_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_advertisements_has_promotions_promotions1`
    FOREIGN KEY (`promotions_promotion_id`)
    REFERENCES `promotions` (`promotion_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `advertisements_has_organization`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `advertisements_has_organization` (
  `advertisements_advertisement_id` INT NOT NULL,
  `organization_organization_id` INT NOT NULL,
  PRIMARY KEY (`advertisements_advertisement_id`, `organization_organization_id`),
  INDEX `fk_advertisements_has_organization_organization1_idx` (`organization_organization_id` ASC) VISIBLE,
  INDEX `fk_advertisements_has_organization_advertisements1_idx` (`advertisements_advertisement_id` ASC) VISIBLE,
  CONSTRAINT `fk_advertisements_has_organization_advertisements1`
    FOREIGN KEY (`advertisements_advertisement_id`)
    REFERENCES `advertisements` (`advertisement_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_advertisements_has_organization_organization1`
    FOREIGN KEY (`organization_organization_id`)
    REFERENCES `organization` (`organization_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `payment_method`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `payment_method` (
  `payment_method_id` INT NOT NULL,
  `account_id` INT NOT NULL,
  `payment_amount` INT NOT NULL,
  `payment_type` INT NOT NULL,
  PRIMARY KEY (`payment_method_id`),
  UNIQUE INDEX `payment_method_id_UNIQUE` (`payment_method_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `premium_has_payment_method`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `premium_has_payment_method` (
  `premium_premium_id` INT NOT NULL,
  `payment_method_payment_method_id` INT NOT NULL,
  PRIMARY KEY (`premium_premium_id`, `payment_method_payment_method_id`),
  INDEX `fk_premium_has_payment_method_payment_method1_idx` (`payment_method_payment_method_id` ASC) VISIBLE,
  CONSTRAINT `fk_premium_has_payment_method_premium1`
    FOREIGN KEY (`premium_premium_id`)
    REFERENCES `premium` (`premium_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_premium_has_payment_method_payment_method1`
    FOREIGN KEY (`payment_method_payment_method_id`)
    REFERENCES `payment_method` (`payment_method_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bank_account`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bank_account` (
  `account_number` INT NOT NULL,
  `routing_number` INT NOT NULL,
  `acc_holder_name` VARCHAR(45) NOT NULL,
  `bank_name` VARCHAR(45) NOT NULL,
  `payment_method_payment_method_id` INT NOT NULL,
  PRIMARY KEY (`payment_method_payment_method_id`, `account_number`),
  INDEX `fk_bank_account_payment_method1_idx` (`payment_method_payment_method_id` ASC) VISIBLE,
  UNIQUE INDEX `account_number_UNIQUE` (`account_number` ASC) VISIBLE,
  CONSTRAINT `fk_bank_account_payment_method1`
    FOREIGN KEY (`payment_method_payment_method_id`)
    REFERENCES `payment_method` (`payment_method_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paypal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paypal` (
  `paypal_id` INT NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `payment_method_payment_method_id` INT NOT NULL,
  PRIMARY KEY (`paypal_id`, `payment_method_payment_method_id`),
  INDEX `fk_paypal_payment_method1_idx` (`payment_method_payment_method_id` ASC) VISIBLE,
  CONSTRAINT `fk_paypal_payment_method1`
    FOREIGN KEY (`payment_method_payment_method_id`)
    REFERENCES `payment_method` (`payment_method_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `credit_card`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `credit_card` (
  `credit_card_number` INT(12) NOT NULL,
  `credit_card_holder_name` VARCHAR(45) NOT NULL,
  `CVV` INT(3) NOT NULL,
  `zipcode` INT(5) NOT NULL,
  `expiration_date` DATE NOT NULL,
  `payment_method_payment_method_id` INT NOT NULL,
  PRIMARY KEY (`credit_card_number`, `payment_method_payment_method_id`),
  INDEX `fk_credit_card_payment_method1_idx` (`payment_method_payment_method_id` ASC) VISIBLE,
  CONSTRAINT `fk_credit_card_payment_method1`
    FOREIGN KEY (`payment_method_payment_method_id`)
    REFERENCES `payment_method` (`payment_method_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `debit_card`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `debit_card` (
  `debit_card_number` INT NOT NULL,
  `expiration_date` DATE NOT NULL,
  `CVV` INT(3) NOT NULL,
  `debit_card_holder_name` VARCHAR(45) NOT NULL,
  `bank_account_account_number` INT NOT NULL,
  PRIMARY KEY (`debit_card_number`, `bank_account_account_number`),
  INDEX `fk_debit_card_bank_account1_idx` (`bank_account_account_number` ASC) VISIBLE,
  CONSTRAINT `fk_debit_card_bank_account1`
    FOREIGN KEY (`bank_account_account_number`)
    REFERENCES `bank_account` (`account_number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CDN`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CDN` (
  `cdn_id` INT NOT NULL AUTO_INCREMENT,
  `manifest_id` INT NOT NULL,
  `region_region_id` INT NOT NULL,
  PRIMARY KEY (`cdn_id`),
  UNIQUE INDEX `cdn_id_UNIQUE` (`cdn_id` ASC) VISIBLE,
  UNIQUE INDEX `manifest_id_UNIQUE` (`manifest_id` ASC) VISIBLE,
  INDEX `fk_CDN_region1_idx` (`region_region_id` ASC) VISIBLE,
  CONSTRAINT `fk_CDN_region1`
    FOREIGN KEY (`region_region_id`)
    REFERENCES `region` (`region_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Multimedia_Content`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Multimedia_Content` (
  `cdn_id` INT NOT NULL,
  `premium_actions` INT NOT NULL,
  PRIMARY KEY (`cdn_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Multimedia_Content_has_CDN`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Multimedia_Content_has_CDN` (
  `Multimedia_Content_cdn_id` INT NOT NULL,
  `CDN_cdn_id` INT NOT NULL,
  PRIMARY KEY (`Multimedia_Content_cdn_id`, `CDN_cdn_id`),
  INDEX `fk_Multimedia_Content_has_CDN_CDN1_idx` (`CDN_cdn_id` ASC) VISIBLE,
  INDEX `fk_Multimedia_Content_has_CDN_Multimedia_Content1_idx` (`Multimedia_Content_cdn_id` ASC) VISIBLE,
  CONSTRAINT `fk_Multimedia_Content_has_CDN_Multimedia_Content1`
    FOREIGN KEY (`Multimedia_Content_cdn_id`)
    REFERENCES `Multimedia_Content` (`cdn_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Multimedia_Content_has_CDN_CDN1`
    FOREIGN KEY (`CDN_cdn_id`)
    REFERENCES `CDN` (`cdn_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `authors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `authors` (
  `author_id` INT NOT NULL,
  `author_name` VARCHAR(45) NOT NULL,
  `author_description` VARCHAR(45) NULL,
  PRIMARY KEY (`author_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Multimedia_Content_has_authors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Multimedia_Content_has_authors` (
  `Multimedia_Content_cdn_id` INT NOT NULL,
  `authors_author_id` INT NOT NULL,
  PRIMARY KEY (`Multimedia_Content_cdn_id`, `authors_author_id`),
  INDEX `fk_Multimedia_Content_has_authors_authors1_idx` (`authors_author_id` ASC) VISIBLE,
  INDEX `fk_Multimedia_Content_has_authors_Multimedia_Content1_idx` (`Multimedia_Content_cdn_id` ASC) VISIBLE,
  CONSTRAINT `fk_Multimedia_Content_has_authors_Multimedia_Content1`
    FOREIGN KEY (`Multimedia_Content_cdn_id`)
    REFERENCES `Multimedia_Content` (`cdn_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Multimedia_Content_has_authors_authors1`
    FOREIGN KEY (`authors_author_id`)
    REFERENCES `authors` (`author_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `podcast`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `podcast` (
  `podcast_id` INT NOT NULL,
  `podcast_title` VARCHAR(45) NOT NULL,
  `Multimedia_Content_cdn_id` INT NOT NULL,
  PRIMARY KEY (`podcast_id`, `Multimedia_Content_cdn_id`),
  INDEX `fk_podcast_Multimedia_Content1_idx` (`Multimedia_Content_cdn_id` ASC) VISIBLE,
  CONSTRAINT `fk_podcast_Multimedia_Content1`
    FOREIGN KEY (`Multimedia_Content_cdn_id`)
    REFERENCES `Multimedia_Content` (`cdn_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `music`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `music` (
  `music_id` INT NOT NULL,
  `music_title` VARCHAR(45) NOT NULL,
  `duration` TIME NOT NULL,
  `Multimedia_Content_cdn_id` INT NOT NULL,
  `music_author_name` VARCHAR(45) NULL,
  `music_release_year` YEAR NOT NULL,
  PRIMARY KEY (`music_id`, `Multimedia_Content_cdn_id`),
  INDEX `fk_music_Multimedia_Content1_idx` (`Multimedia_Content_cdn_id` ASC) VISIBLE,
  CONSTRAINT `fk_music_Multimedia_Content1`
    FOREIGN KEY (`Multimedia_Content_cdn_id`)
    REFERENCES `Multimedia_Content` (`cdn_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `audio_books`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `audio_books` (
  `audio_book_id` INT NOT NULL,
  `audio_book_name` VARCHAR(45) NOT NULL,
  `audio_book_duration` TIME NOT NULL,
  `Multimedia_Content_cdn_id` INT NOT NULL,
  `audiobook_release_date` DATE NOT NULL,
  PRIMARY KEY (`audio_book_id`),
  INDEX `fk_audio_books_Multimedia_Content1_idx` (`Multimedia_Content_cdn_id` ASC) VISIBLE,
  CONSTRAINT `fk_audio_books_Multimedia_Content1`
    FOREIGN KEY (`Multimedia_Content_cdn_id`)
    REFERENCES `Multimedia_Content` (`cdn_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `publisher`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `publisher` (
  `publisher_id` INT NOT NULL AUTO_INCREMENT,
  `publisher_name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NULL,
  PRIMARY KEY (`publisher_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `published_podcast`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `published_podcast` (
  `published_podcast_id` INT NOT NULL AUTO_INCREMENT,
  `publisher_publisher_id` INT NOT NULL,
  `podcast_podcast_id` INT NOT NULL,
  PRIMARY KEY (`published_podcast_id`, `publisher_publisher_id`),
  INDEX `fk_published_podcast_publisher1_idx` (`publisher_publisher_id` ASC) VISIBLE,
  INDEX `fk_published_podcast_podcast1_idx` (`podcast_podcast_id` ASC) VISIBLE,
  CONSTRAINT `fk_published_podcast_publisher1`
    FOREIGN KEY (`publisher_publisher_id`)
    REFERENCES `publisher` (`publisher_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_published_podcast_podcast1`
    FOREIGN KEY (`podcast_podcast_id`)
    REFERENCES `podcast` (`podcast_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `published_music`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `published_music` (
  `music_id` INT NOT NULL AUTO_INCREMENT,
  `publisher_publisher_id` INT NOT NULL,
  PRIMARY KEY (`music_id`, `publisher_publisher_id`),
  INDEX `fk_published_music_publisher1_idx` (`publisher_publisher_id` ASC) VISIBLE,
  CONSTRAINT `fk_published_music_publisher1`
    FOREIGN KEY (`publisher_publisher_id`)
    REFERENCES `publisher` (`publisher_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_published_music_music1`
    FOREIGN KEY (`music_id`)
    REFERENCES `music` (`music_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `published_audiobooks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `published_audiobooks` (
  `published_audiobooks_id` INT NOT NULL,
  `publisher_publisher_id` INT NOT NULL,
  `audio_books_audio_book_id` INT NOT NULL,
  PRIMARY KEY (`published_audiobooks_id`, `publisher_publisher_id`),
  INDEX `fk_published_audiobooks_publisher1_idx` (`publisher_publisher_id` ASC) VISIBLE,
  INDEX `fk_published_audiobooks_audio_books1_idx` (`audio_books_audio_book_id` ASC) VISIBLE,
  CONSTRAINT `fk_published_audiobooks_publisher1`
    FOREIGN KEY (`publisher_publisher_id`)
    REFERENCES `publisher` (`publisher_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_published_audiobooks_audio_books1`
    FOREIGN KEY (`audio_books_audio_book_id`)
    REFERENCES `audio_books` (`audio_book_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Basic_can_stream_music`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Basic_can_stream_music` (
  `Basic_basic_id` INT NOT NULL,
  `music_music_id` INT NOT NULL,
  PRIMARY KEY (`Basic_basic_id`, `music_music_id`),
  INDEX `fk_Basic_has_music_music1_idx` (`music_music_id` ASC) VISIBLE,
  CONSTRAINT `fk_Basic_has_music_Basic1`
    FOREIGN KEY (`Basic_basic_id`)
    REFERENCES `Basic` (`basic_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Basic_has_music_music1`
    FOREIGN KEY (`music_music_id`)
    REFERENCES `music` (`music_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Basic_can_stream_podcast`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Basic_can_stream_podcast` (
  `Basic_basic_id` INT NOT NULL,
  `podcast_podcast_id` INT NOT NULL,
  PRIMARY KEY (`Basic_basic_id`, `podcast_podcast_id`),
  INDEX `fk_Basic_has_podcast_podcast1_idx` (`podcast_podcast_id` ASC) VISIBLE,
  CONSTRAINT `fk_Basic_has_podcast_Basic1`
    FOREIGN KEY (`Basic_basic_id`)
    REFERENCES `Basic` (`basic_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Basic_has_podcast_podcast1`
    FOREIGN KEY (`podcast_podcast_id`)
    REFERENCES `podcast` (`podcast_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `actions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `actions` (
  `action_id` INT NOT NULL,
  `action_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`action_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `premium_action`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `premium_action` (
  `premium_premium_id` INT NOT NULL,
  `Multimedia_Content_cdn_id` INT NOT NULL,
  `actions_action_id` INT NOT NULL,
  `premium_action_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`premium_premium_id`, `Multimedia_Content_cdn_id`),
  INDEX `fk_premium_has_Multimedia_Content_Multimedia_Content1_idx` (`Multimedia_Content_cdn_id` ASC) VISIBLE,
  INDEX `fk_premium_action_actions1_idx` (`actions_action_id` ASC) VISIBLE,
  CONSTRAINT `fk_premium_has_Multimedia_Content_premium1`
    FOREIGN KEY (`premium_premium_id`)
    REFERENCES `premium` (`premium_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_premium_has_Multimedia_Content_Multimedia_Content1`
    FOREIGN KEY (`Multimedia_Content_cdn_id`)
    REFERENCES `Multimedia_Content` (`cdn_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_premium_action_actions1`
    FOREIGN KEY (`actions_action_id`)
    REFERENCES `actions` (`action_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `multimedia_tracker`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `multimedia_tracker` (
  `tracker_id` INT NOT NULL,
  `author_id` INT NOT NULL,
  `date_time` DATETIME NOT NULL,
  PRIMARY KEY (`tracker_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `premium_action_has_multimedia_tracker`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `premium_action_has_multimedia_tracker` (
  `premium_action_premium_premium_id` INT NOT NULL,
  `multimedia_tracker_tracker_id` INT NOT NULL,
  PRIMARY KEY (`premium_action_premium_premium_id`, `multimedia_tracker_tracker_id`),
  INDEX `fk_premium_action_has_multimedia_tracker_multimedia_tracker_idx` (`multimedia_tracker_tracker_id` ASC) VISIBLE,
  CONSTRAINT `fk_premium_action_has_multimedia_tracker_premium_action1`
    FOREIGN KEY (`premium_action_premium_premium_id`)
    REFERENCES `premium_action` (`premium_premium_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_premium_action_has_multimedia_tracker_multimedia_tracker1`
    FOREIGN KEY (`multimedia_tracker_tracker_id`)
    REFERENCES `multimedia_tracker` (`tracker_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `student_plan`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `student_plan` (
  `student_plan_id` INT NOT NULL,
  `student_plan_cost` INT NULL DEFAULT 5,
  `premium_premium_id` INT NOT NULL,
  PRIMARY KEY (`student_plan_id`, `premium_premium_id`),
  INDEX `fk_student_plan_premium1_idx` (`premium_premium_id` ASC) VISIBLE,
  CONSTRAINT `fk_student_plan_premium1`
    FOREIGN KEY (`premium_premium_id`)
    REFERENCES `premium` (`premium_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `group_plan`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `group_plan` (
  `group_plan_id` INT NOT NULL,
  `group_plan_cost` INT NULL DEFAULT 20,
  `premium_premium_id` INT NOT NULL,
  PRIMARY KEY (`group_plan_id`, `premium_premium_id`),
  INDEX `fk_group_plan_premium1_idx` (`premium_premium_id` ASC) VISIBLE,
  CONSTRAINT `fk_group_plan_premium1`
    FOREIGN KEY (`premium_premium_id`)
    REFERENCES `premium` (`premium_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `individual_plan`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `individual_plan` (
  `individual_plan_id` INT NOT NULL,
  `individual_plan_cost` INT NULL DEFAULT 10,
  `premium_premium_id` INT NOT NULL,
  PRIMARY KEY (`individual_plan_id`, `premium_premium_id`),
  INDEX `fk_individual_plan_premium1_idx` (`premium_premium_id` ASC) VISIBLE,
  CONSTRAINT `fk_individual_plan_premium1`
    FOREIGN KEY (`premium_premium_id`)
    REFERENCES `premium` (`premium_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `profile`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `profile` (
  `role_id` INT NOT NULL,
  `alias` VARCHAR(45) NULL,
  `group_plan_group_plan_id` INT NOT NULL,
  PRIMARY KEY (`role_id`),
  INDEX `fk_profile_group_plan1_idx` (`group_plan_group_plan_id` ASC) VISIBLE,
  CONSTRAINT `fk_profile_group_plan1`
    FOREIGN KEY (`group_plan_group_plan_id`)
    REFERENCES `group_plan` (`group_plan_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `manifest`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `manifest` (
  `manifest_id` INT NOT NULL,
  `region` VARCHAR(45) NOT NULL,
  `manifesturl` VARCHAR(45) NULL,
  PRIMARY KEY (`manifest_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `manifest_has_CDN`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `manifest_has_CDN` (
  `manifest_manifest_id` INT NOT NULL,
  `CDN_cdn_id` INT NOT NULL,
  PRIMARY KEY (`manifest_manifest_id`, `CDN_cdn_id`),
  INDEX `fk_manifest_has_CDN_CDN1_idx` (`CDN_cdn_id` ASC) VISIBLE,
  INDEX `fk_manifest_has_CDN_manifest1_idx` (`manifest_manifest_id` ASC) VISIBLE,
  CONSTRAINT `fk_manifest_has_CDN_manifest1`
    FOREIGN KEY (`manifest_manifest_id`)
    REFERENCES `manifest` (`manifest_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_manifest_has_CDN_CDN1`
    FOREIGN KEY (`CDN_cdn_id`)
    REFERENCES `CDN` (`cdn_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
