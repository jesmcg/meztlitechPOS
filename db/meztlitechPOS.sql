CREATE SCHEMA IF NOT EXISTS `meztitechpos` DEFAULT CHARACTER SET latin1 ;
USE `meztitechpos` ;

-- -----------------------------------------------------
-- Table `meztitechpos`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `meztitechpos`.`users` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NULL DEFAULT NULL,
  `lastname` VARCHAR(45) NULL DEFAULT NULL,
  `mothersname` VARCHAR(45) NULL DEFAULT NULL,
  `email` VARCHAR(45) NOT NULL,
  `password` TEXT NULL DEFAULT NULL,
  `date_register` DATETIME NOT NULL,
  `date_update` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `meztitechpos`.`market`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `meztitechpos`.`market` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `maket_name` VARCHAR(50) NOT NULL,
  `description` TEXT NULL DEFAULT NULL,
  `date_register` DATETIME NULL DEFAULT NULL,
  `date_update` DATETIME NULL DEFAULT NULL,
  `owner` BIGINT(20) UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `owner` (`owner` ASC),
  CONSTRAINT `market_ibfk_1`
    FOREIGN KEY (`owner`)
    REFERENCES `meztitechpos`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `meztitechpos`.`branch`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `meztitechpos`.`branch` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `branch_name` VARCHAR(70) NULL DEFAULT NULL,
  `addreess` TEXT NULL DEFAULT NULL,
  `num_out` VARCHAR(10) NULL DEFAULT NULL,
  `num_ins` VARCHAR(10) NULL DEFAULT NULL,
  `city` VARCHAR(45) NULL DEFAULT NULL,
  `description` TEXT NULL DEFAULT NULL,
  `market_owner` BIGINT(20) UNSIGNED NOT NULL,
  `date_insert` DATETIME NULL DEFAULT NULL,
  `date_update` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `market_owner` (`market_owner` ASC),
  CONSTRAINT `branch_ibfk_1`
    FOREIGN KEY (`market_owner`)
    REFERENCES `meztitechpos`.`market` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `meztitechpos`.`providers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `meztitechpos`.`providers` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `provider_name` VARCHAR(60) NULL DEFAULT NULL,
  `provider_rfc` VARCHAR(45) NULL DEFAULT NULL,
  `date_insert` DATETIME NULL DEFAULT NULL,
  `date_update` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `meztitechpos`.`payment_types`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `meztitechpos`.`payment_types` (
  `id` TINYINT(4) NOT NULL AUTO_INCREMENT,
  `payment_name` VARCHAR(45) NULL DEFAULT NULL,
  `description` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `meztitechpos`.`sellers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `meztitechpos`.`sellers` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NULL DEFAULT NULL,
  `lastname` VARCHAR(45) NULL DEFAULT NULL,
  `mothersname` VARCHAR(45) NULL DEFAULT NULL,
  `email` VARCHAR(45) NOT NULL,
  `password` TEXT NOT NULL,
  `date_register` DATETIME NOT NULL,
  `date_update` DATETIME NULL DEFAULT NULL,
  `owner` BIGINT(20) UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `owner` (`owner` ASC),
  CONSTRAINT `sellers_ibfk_1`
    FOREIGN KEY (`owner`)
    REFERENCES `meztitechpos`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `meztitechpos`.`buy`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `meztitechpos`.`buy` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `total_buy` FLOAT NULL DEFAULT '0',
  `payment_type` TINYINT(4) NULL DEFAULT NULL,
  `date_buy` DATETIME NULL DEFAULT NULL,
  `update_buy` DATETIME NULL DEFAULT NULL,
  `buyer` BIGINT(20) UNSIGNED NULL DEFAULT NULL,
  `provider` BIGINT(20) UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `provider` (`provider` ASC),
  INDEX `payment_type` (`payment_type` ASC),
  INDEX `buyer` (`buyer` ASC),
  CONSTRAINT `buy_ibfk_1`
    FOREIGN KEY (`provider`)
    REFERENCES `meztitechpos`.`providers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `buy_ibfk_2`
    FOREIGN KEY (`payment_type`)
    REFERENCES `meztitechpos`.`payment_types` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `buy_ibfk_3`
    FOREIGN KEY (`buyer`)
    REFERENCES `meztitechpos`.`sellers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `meztitechpos`.`clients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `meztitechpos`.`clients` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `clientname` VARCHAR(45) NULL DEFAULT NULL,
  `lastname` VARCHAR(45) NULL DEFAULT NULL,
  `mothersname` VARCHAR(45) NULL DEFAULT NULL,
  `email` VARCHAR(45) NULL DEFAULT NULL,
  `password` TEXT NULL DEFAULT NULL,
  `rfc` VARCHAR(45) NULL DEFAULT NULL,
  `date_register` DATETIME NULL DEFAULT NULL,
  `date_update` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `meztitechpos`.`store`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `meztitechpos`.`store` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name_store` VARCHAR(70) NOT NULL,
  `description` TEXT NULL DEFAULT NULL,
  `branch` BIGINT(20) UNSIGNED NOT NULL,
  `date_inser` DATETIME NULL DEFAULT NULL,
  `date_update` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `branch` (`branch` ASC),
  CONSTRAINT `store_ibfk_1`
    FOREIGN KEY (`branch`)
    REFERENCES `meztitechpos`.`branch` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `meztitechpos`.`products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `meztitechpos`.`products` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `product_code` TEXT NULL DEFAULT NULL,
  `product_name` VARCHAR(45) NULL DEFAULT NULL,
  `cuantity` INT(11) NULL DEFAULT NULL,
  `unit_price` FLOAT NULL DEFAULT '0',
  `sale_price` FLOAT NULL DEFAULT '0',
  `provider` BIGINT(20) UNSIGNED NULL DEFAULT NULL,
  `date_insert` DATETIME NULL DEFAULT NULL,
  `date_update` DATETIME NULL DEFAULT NULL,
  `store` BIGINT(20) UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `store` (`store` ASC),
  INDEX `provider` (`provider` ASC),
  CONSTRAINT `products_ibfk_1`
    FOREIGN KEY (`store`)
    REFERENCES `meztitechpos`.`store` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `products_ibfk_2`
    FOREIGN KEY (`provider`)
    REFERENCES `meztitechpos`.`providers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `meztitechpos`.`detail_buy`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `meztitechpos`.`detail_buy` (
  `buy` BIGINT(20) UNSIGNED NULL DEFAULT NULL,
  `product` INT(10) UNSIGNED NULL DEFAULT NULL,
  `cuantity` INT(11) NULL DEFAULT NULL,
  `amount` FLOAT NULL DEFAULT '0',
  INDEX `buy` (`buy` ASC),
  INDEX `product` (`product` ASC),
  CONSTRAINT `detail_buy_ibfk_1`
    FOREIGN KEY (`buy`)
    REFERENCES `meztitechpos`.`buy` (`id`),
  CONSTRAINT `detail_buy_ibfk_2`
    FOREIGN KEY (`product`)
    REFERENCES `meztitechpos`.`products` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `meztitechpos`.`sale`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `meztitechpos`.`sale` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `total_sale` FLOAT NULL DEFAULT '0',
  `payment_type` TINYINT(4) NULL DEFAULT NULL,
  `date_sale` DATETIME NULL DEFAULT NULL,
  `update_sale` DATETIME NULL DEFAULT NULL,
  `seller` BIGINT(20) UNSIGNED NULL DEFAULT NULL,
  `client` BIGINT(20) UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `seller` (`seller` ASC),
  INDEX `payment_type` (`payment_type` ASC),
  INDEX `client` (`client` ASC),
  CONSTRAINT `sale_ibfk_1`
    FOREIGN KEY (`seller`)
    REFERENCES `meztitechpos`.`sellers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `sale_ibfk_2`
    FOREIGN KEY (`payment_type`)
    REFERENCES `meztitechpos`.`payment_types` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `sale_ibfk_3`
    FOREIGN KEY (`client`)
    REFERENCES `meztitechpos`.`clients` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `meztitechpos`.`detail_sale`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `meztitechpos`.`detail_sale` (
  `sale` BIGINT(20) UNSIGNED NULL DEFAULT NULL,
  `product` INT(10) UNSIGNED NULL DEFAULT NULL,
  `cuantity` FLOAT NULL DEFAULT '0',
  `amount` DATETIME NULL DEFAULT NULL,
  INDEX `sale` (`sale` ASC),
  INDEX `product` (`product` ASC),
  CONSTRAINT `detail_sale_ibfk_1`
    FOREIGN KEY (`sale`)
    REFERENCES `meztitechpos`.`sale` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `detail_sale_ibfk_2`
    FOREIGN KEY (`product`)
    REFERENCES `meztitechpos`.`products` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
