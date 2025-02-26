CREATE DATABASE  IF NOT EXISTS `ocorrenciasescolares` /*!40100 DEFAULT CHARACTER SET utf8mb3 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `ocorrenciasescolares`;
-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: ocorrenciasescolares
-- ------------------------------------------------------
-- Server version	8.0.37

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `aluno`
--

DROP TABLE IF EXISTS `aluno`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aluno` (
  `matricula` int unsigned NOT NULL,
  `nome` varchar(45) DEFAULT NULL,
  `turma` varchar(45) DEFAULT NULL,
  `nascimento` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`matricula`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aluno`
--

LOCK TABLES `aluno` WRITE;
/*!40000 ALTER TABLE `aluno` DISABLE KEYS */;
INSERT INTO `aluno` VALUES (50230299,'Heitor','3ºH','06/08/2007');
/*!40000 ALTER TABLE `aluno` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `funcionario`
--

DROP TABLE IF EXISTS `funcionario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `funcionario` (
  `registro` int unsigned NOT NULL,
  `nome` varchar(45) DEFAULT NULL,
  `cpf` varchar(45) DEFAULT NULL,
  `senha` varchar(45) DEFAULT NULL,
  `TipoFuncionario_idTipoFuncionario` int NOT NULL,
  PRIMARY KEY (`registro`),
  UNIQUE KEY `registro_UNIQUE` (`registro`),
  KEY `fk_Funcionario_TipoFuncionario1_idx` (`TipoFuncionario_idTipoFuncionario`),
  CONSTRAINT `fk_Funcionario_TipoFuncionario1` FOREIGN KEY (`TipoFuncionario_idTipoFuncionario`) REFERENCES `tipofuncionario` (`idTipoFuncionario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `funcionario`
--

LOCK TABLES `funcionario` WRITE;
/*!40000 ALTER TABLE `funcionario` DISABLE KEYS */;
INSERT INTO `funcionario` VALUES (1,'Leandro','2025','123',1),(2,'Helio','2024','123',2);
/*!40000 ALTER TABLE `funcionario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `funcionariodisciplina`
--

DROP TABLE IF EXISTS `funcionariodisciplina`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `funcionariodisciplina` (
  `Funcionario_registro` int unsigned NOT NULL,
  `disciplina` varchar(45) DEFAULT NULL,
  `turma` varchar(45) DEFAULT NULL,
  KEY `fk_FuncionarioDisciplina_Funcionario1_idx` (`Funcionario_registro`),
  CONSTRAINT `fk_FuncionarioDisciplina_Funcionario1` FOREIGN KEY (`Funcionario_registro`) REFERENCES `funcionario` (`registro`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `funcionariodisciplina`
--

LOCK TABLES `funcionariodisciplina` WRITE;
/*!40000 ALTER TABLE `funcionariodisciplina` DISABLE KEYS */;
INSERT INTO `funcionariodisciplina` VALUES (2,'Web','3H');
/*!40000 ALTER TABLE `funcionariodisciplina` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `laudo`
--

DROP TABLE IF EXISTS `laudo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `laudo` (
  `idLaudo` int unsigned NOT NULL AUTO_INCREMENT,
  `restricoes` varchar(45) DEFAULT NULL,
  `obs` varchar(45) DEFAULT NULL,
  `tratamentoDiferenciado` varchar(45) DEFAULT NULL,
  `dataCadastro` date DEFAULT NULL,
  `Aluno_matricula` int unsigned NOT NULL,
  PRIMARY KEY (`idLaudo`),
  UNIQUE KEY `idLaudo_UNIQUE` (`idLaudo`),
  KEY `fk_Laudo_Aluno1_idx` (`Aluno_matricula`),
  CONSTRAINT `fk_Laudo_Aluno1` FOREIGN KEY (`Aluno_matricula`) REFERENCES `aluno` (`matricula`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `laudo`
--

LOCK TABLES `laudo` WRITE;
/*!40000 ALTER TABLE `laudo` DISABLE KEYS */;
INSERT INTO `laudo` VALUES (1,'Nenhuma',NULL,'Nenhum','2025-02-14',50230299);
/*!40000 ALTER TABLE `laudo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ocorrencia`
--

DROP TABLE IF EXISTS `ocorrencia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ocorrencia` (
  `idOcorrencia` int NOT NULL,
  `Aluno_matricula` int unsigned NOT NULL,
  `TipoOcorrencia_idTipoOcorrencia` int DEFAULT NULL,
  `Funcionario_registro_Orientador` int unsigned DEFAULT NULL,
  `Funcionario_registro_Professor` int unsigned NOT NULL,
  `relatoFuncionario` varchar(45) DEFAULT NULL,
  `relatoAluno` varchar(45) DEFAULT NULL,
  `condutaOrientacao` varchar(45) DEFAULT NULL,
  `momento` datetime NOT NULL,
  `status` tinyint NOT NULL,
  PRIMARY KEY (`idOcorrencia`),
  KEY `fk_Ocorrencia_TipoOcorrencia_idx` (`TipoOcorrencia_idTipoOcorrencia`),
  KEY `fk_Ocorrencia_Funcionario1_idx` (`Funcionario_registro_Orientador`),
  KEY `fk_Ocorrencia_Funcionario2_idx` (`Funcionario_registro_Professor`),
  KEY `fk_Ocorrencia_Aluno1_idx` (`Aluno_matricula`),
  CONSTRAINT `fk_Ocorrencia_Aluno1` FOREIGN KEY (`Aluno_matricula`) REFERENCES `aluno` (`matricula`),
  CONSTRAINT `fk_Ocorrencia_Funcionario1` FOREIGN KEY (`Funcionario_registro_Orientador`) REFERENCES `funcionario` (`registro`),
  CONSTRAINT `fk_Ocorrencia_Funcionario2` FOREIGN KEY (`Funcionario_registro_Professor`) REFERENCES `funcionario` (`registro`),
  CONSTRAINT `fk_Ocorrencia_TipoOcorrencia` FOREIGN KEY (`TipoOcorrencia_idTipoOcorrencia`) REFERENCES `tipoocorrencia` (`idTipoOcorrencia`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ocorrencia`
--

LOCK TABLES `ocorrencia` WRITE;
/*!40000 ALTER TABLE `ocorrencia` DISABLE KEYS */;
INSERT INTO `ocorrencia` VALUES (1,50230299,1,1,2,'Mexendo no celular','Estava tentando se comunicar com o pai','Retirar o aparelho','2025-02-14 00:00:00',1);
/*!40000 ALTER TABLE `ocorrencia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `responsavel`
--

DROP TABLE IF EXISTS `responsavel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `responsavel` (
  `Aluno_matricula` int unsigned NOT NULL,
  `nomeResponsavel` varchar(45) DEFAULT NULL,
  `telefoneResponsavel` varchar(45) DEFAULT NULL,
  `emailResponsavel` varchar(45) DEFAULT NULL,
  `telefoneRecado` varchar(45) DEFAULT NULL,
  KEY `fk_Responsavel_Aluno1_idx` (`Aluno_matricula`),
  CONSTRAINT `fk_Responsavel_Aluno1` FOREIGN KEY (`Aluno_matricula`) REFERENCES `aluno` (`matricula`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `responsavel`
--

LOCK TABLES `responsavel` WRITE;
/*!40000 ALTER TABLE `responsavel` DISABLE KEYS */;
INSERT INTO `responsavel` VALUES (50230299,'Julia Massako','11987654321','maria@email.com','11912345678');
/*!40000 ALTER TABLE `responsavel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tentativanotificacaoresponsaveis`
--

DROP TABLE IF EXISTS `tentativanotificacaoresponsaveis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tentativanotificacaoresponsaveis` (
  `idTentativaNotificacaoResponsaveis` int unsigned NOT NULL AUTO_INCREMENT,
  `Ocorrencia_idOcorrencia` int NOT NULL,
  `Obs` varchar(45) DEFAULT NULL,
  `momento` datetime DEFAULT NULL,
  PRIMARY KEY (`idTentativaNotificacaoResponsaveis`),
  UNIQUE KEY `idTentativaNotificacaoResponsaveis_UNIQUE` (`idTentativaNotificacaoResponsaveis`),
  KEY `fk_TentativaNotificacaoResponsaveis_Ocorrencia1_idx` (`Ocorrencia_idOcorrencia`),
  CONSTRAINT `fk_TentativaNotificacaoResponsaveis_Ocorrencia1` FOREIGN KEY (`Ocorrencia_idOcorrencia`) REFERENCES `ocorrencia` (`idOcorrencia`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tentativanotificacaoresponsaveis`
--

LOCK TABLES `tentativanotificacaoresponsaveis` WRITE;
/*!40000 ALTER TABLE `tentativanotificacaoresponsaveis` DISABLE KEYS */;
INSERT INTO `tentativanotificacaoresponsaveis` VALUES (1,1,'nao atendeu','2025-02-14 00:00:00');
/*!40000 ALTER TABLE `tentativanotificacaoresponsaveis` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipofuncionario`
--

DROP TABLE IF EXISTS `tipofuncionario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipofuncionario` (
  `idTipoFuncionario` int NOT NULL AUTO_INCREMENT,
  `tipo` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idTipoFuncionario`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipofuncionario`
--

LOCK TABLES `tipofuncionario` WRITE;
/*!40000 ALTER TABLE `tipofuncionario` DISABLE KEYS */;
INSERT INTO `tipofuncionario` VALUES (1,'Cordenador'),(2,'Professor');
/*!40000 ALTER TABLE `tipofuncionario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipoocorrencia`
--

DROP TABLE IF EXISTS `tipoocorrencia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipoocorrencia` (
  `idTipoOcorrencia` int NOT NULL AUTO_INCREMENT,
  `tipo` varchar(45) DEFAULT NULL,
  `conduta` varchar(45) DEFAULT NULL,
  `peso` int DEFAULT NULL,
  `obs` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idTipoOcorrencia`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipoocorrencia`
--

LOCK TABLES `tipoocorrencia` WRITE;
/*!40000 ALTER TABLE `tipoocorrencia` DISABLE KEYS */;
INSERT INTO `tipoocorrencia` VALUES (1,'Celular','Retirar o aparelho',1,'NULL');
/*!40000 ALTER TABLE `tipoocorrencia` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-02-26 18:56:38
