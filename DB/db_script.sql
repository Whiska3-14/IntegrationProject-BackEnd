-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema alejandria_test
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema alejandria_test
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `alejandria_test` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `alejandria_test` ;

-- -----------------------------------------------------
-- Table `alejandria_test`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `alejandria_test`.`usuarios` (
  `id_usuarios` INT ZEROFILL NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido_p` VARCHAR(45) NOT NULL,
  `apellido_m` VARCHAR(45) NULL,
  `email` VARCHAR(45) NOT NULL,
  `contrasenia` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(20) NULL,
  PRIMARY KEY (`id_usuarios`),
  UNIQUE INDEX `id_usuarios_UNIQUE` (`id_usuarios` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alejandria_test`.`libros`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `alejandria_test`.`libros` (
  `id_libros` INT ZEROFILL NOT NULL AUTO_INCREMENT,
  `precio` DECIMAL(4,2) NOT NULL,
  `autor` VARCHAR(45) NOT NULL,
  `isbn` VARCHAR(15) NOT NULL,
  `titulo` VARCHAR(255) NOT NULL,
  `editorial` VARCHAR(45) NULL,
  `edicion` VARCHAR(45) NULL,
  `fecha_publicacion` DATE NOT NULL,
  `num_paginas` INT NULL,
  `inventario` INT NOT NULL,
  `idioma` VARCHAR(45) NULL,
  `tipo_pasta` SET("Pasta dura", "Pasta blanda") NOT NULL,
  `sinopsis` TEXT NULL,
  `url_portada` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id_libros`),
  UNIQUE INDEX `id_libros_UNIQUE` (`id_libros` ASC) VISIBLE,
  UNIQUE INDEX `isbn_UNIQUE` (`isbn` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alejandria_test`.`envios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `alejandria_test`.`envios` (
  `id_envios` INT ZEROFILL NOT NULL AUTO_INCREMENT,
  `calle` VARCHAR(255) NOT NULL,
  `ciudad` VARCHAR(100) NOT NULL,
  `codigo_postal` INT(5) NOT NULL,
  `estado` VARCHAR(45) NOT NULL,
  `numero_exterior` VARCHAR(45) NOT NULL,
  `numero_interior` VARCHAR(45) NULL,
  `colonia` VARCHAR(45) NOT NULL,
  `referencias` VARCHAR(500) NULL,
  PRIMARY KEY (`id_envios`),
  UNIQUE INDEX `id_envios_UNIQUE` (`id_envios` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alejandria_test`.`ordenes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `alejandria_test`.`ordenes` (
  `id_ordenes` INT ZEROFILL NOT NULL AUTO_INCREMENT,
  `fecha_orden` DATETIME NOT NULL DEFAULT current_timestamp,
  `total` DECIMAL(10,2) NOT NULL,
  `metodo_pago` SET("Tarjeta", "Deposito") NOT NULL,
  `estado` SET("Enviado", "Entregado", "Cancelado", "Pendiente") NOT NULL,
  `usuarios_id_usuarios` INT ZEROFILL NOT NULL,
  `envios_id_envios` INT ZEROFILL NOT NULL,
  PRIMARY KEY (`id_ordenes`),
  UNIQUE INDEX `id_ordenes_UNIQUE` (`id_ordenes` ASC) VISIBLE,
  INDEX `fk_ordenes_usuarios_idx` (`usuarios_id_usuarios` ASC) VISIBLE,
  INDEX `fk_ordenes_envios1_idx` (`envios_id_envios` ASC) VISIBLE,
  CONSTRAINT `fk_ordenes_usuarios`
    FOREIGN KEY (`usuarios_id_usuarios`)
    REFERENCES `alejandria_test`.`usuarios` (`id_usuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ordenes_envios1`
    FOREIGN KEY (`envios_id_envios`)
    REFERENCES `alejandria_test`.`envios` (`id_envios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alejandria_test`.`orden_producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `alejandria_test`.`orden_producto` (
  `id_orden_producto` INT ZEROFILL NOT NULL AUTO_INCREMENT,
  `ordenes_id_ordenes` INT ZEROFILL NOT NULL,
  `precio` DECIMAL(4,2) NOT NULL,
  `cantidad` INT NOT NULL,
  `libros_id_libros` INT ZEROFILL NOT NULL,
  PRIMARY KEY (`id_orden_producto`),
  INDEX `fk_orden_producto_ordenes1_idx` (`ordenes_id_ordenes` ASC) VISIBLE,
  UNIQUE INDEX `id_orden_producto_UNIQUE` (`id_orden_producto` ASC) VISIBLE,
  INDEX `fk_orden_producto_libros1_idx` (`libros_id_libros` ASC) VISIBLE,
  CONSTRAINT `fk_orden_producto_ordenes1`
    FOREIGN KEY (`ordenes_id_ordenes`)
    REFERENCES `alejandria_test`.`ordenes` (`id_ordenes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orden_producto_libros1`
    FOREIGN KEY (`libros_id_libros`)
    REFERENCES `alejandria_test`.`libros` (`id_libros`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alejandria_test`.`usuario_privilegios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `alejandria_test`.`usuario_privilegios` (
  `id_usuario_privilegios` INT ZEROFILL NOT NULL AUTO_INCREMENT,
  `usuarios_id_usuarios` INT ZEROFILL NOT NULL,
  `privilegios_id_privilegios` INT NOT NULL,
  `es_administrador` SET("administrador", "editor", "usuario_normal") NOT NULL,
  PRIMARY KEY (`id_usuario_privilegios`),
  INDEX `fk_usuario_privilegios_usuarios1_idx` (`usuarios_id_usuarios` ASC) VISIBLE,
  UNIQUE INDEX `id_usuario_privilegios_UNIQUE` (`id_usuario_privilegios` ASC) VISIBLE,
  CONSTRAINT `fk_usuario_privilegios_usuarios1`
    FOREIGN KEY (`usuarios_id_usuarios`)
    REFERENCES `alejandria_test`.`usuarios` (`id_usuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alejandria_test`.`formulario_contacto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `alejandria_test`.`formulario_contacto` (
  `id_formulario_contacto` INT ZEROFILL NOT NULL AUTO_INCREMENT,
  `asunto` VARCHAR(50) NOT NULL,
  `mensaje` VARCHAR(250) NOT NULL,
  `telefono` VARCHAR(20) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_formulario_contacto`),
  UNIQUE INDEX `id_formulario_contacto_UNIQUE` (`id_formulario_contacto` ASC) VISIBLE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
