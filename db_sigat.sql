-- --------------------------------------------------------
-- Servidor:                     127.0.0.1
-- Versão do servidor:           5.7.33-log - MySQL Community Server (GPL)
-- OS do Servidor:               Win64
-- HeidiSQL Versão:              11.2.0.6213
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Copiando estrutura do banco de dados para db_sigat
CREATE DATABASE IF NOT EXISTS `db_sigat` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `db_sigat`;

-- Copiando estrutura para tabela db_sigat.anexo
CREATE TABLE IF NOT EXISTS `anexo` (
  `id_anexo` int(11) NOT NULL AUTO_INCREMENT,
  `nome_anexo` varchar(45) DEFAULT NULL,
  `data_anexo` datetime DEFAULT NULL,
  `id_chamado_anexo` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_anexo`),
  KEY `fk_anexo_chamado_idx` (`id_chamado_anexo`),
  CONSTRAINT `fk_anexo_chamado` FOREIGN KEY (`id_chamado_anexo`) REFERENCES `chamado` (`id_chamado`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela db_sigat.anexo: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `anexo` DISABLE KEYS */;
/*!40000 ALTER TABLE `anexo` ENABLE KEYS */;

-- Copiando estrutura para tabela db_sigat.anexos_otrs
CREATE TABLE IF NOT EXISTS `anexos_otrs` (
  `id_anexo_otrs` int(11) NOT NULL,
  `id_chamado_sigat` int(11) NOT NULL,
  `conteudo_anexo_otrs` longblob NOT NULL,
  `nome_arquivo_otrs` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id_anexo_otrs`),
  KEY `fk_id_chamado_sigat` (`id_chamado_sigat`),
  CONSTRAINT `fk_id_chamado_sigat` FOREIGN KEY (`id_chamado_sigat`) REFERENCES `chamado` (`id_chamado`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela db_sigat.anexos_otrs: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `anexos_otrs` DISABLE KEYS */;

-- Copiando estrutura para tabela db_sigat.chamado
CREATE TABLE IF NOT EXISTS `chamado` (
  `id_chamado` int(11) NOT NULL AUTO_INCREMENT,
  `id_local_chamado` int(11) DEFAULT NULL,
  `nome_solicitante_chamado` varchar(60) DEFAULT NULL,
  `descricao_chamado` text,
  `telefone_chamado` varchar(45) DEFAULT NULL,
  `id_usuario_abertura_chamado` int(11) DEFAULT NULL,
  `id_usuario_responsavel_chamado` int(11) DEFAULT NULL,
  `status_chamado` varchar(45) DEFAULT NULL,
  `id_fila_chamado` int(11) DEFAULT NULL,
  `data_chamado` datetime DEFAULT NULL,
  `entrega_chamado` tinyint(4) DEFAULT '0',
  `ticket_chamado` varchar(50) DEFAULT NULL,
  `email_chamado` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_chamado`),
  KEY `fk_local_chamado_idx` (`id_local_chamado`),
  KEY `fk_fila_chamado_idx` (`id_fila_chamado`),
  KEY `fk_usuario_abertura_idx` (`id_usuario_abertura_chamado`,`id_usuario_responsavel_chamado`),
  KEY `fk_resp_chamado_idx` (`id_usuario_responsavel_chamado`),
  CONSTRAINT `fk_fila_chamado` FOREIGN KEY (`id_fila_chamado`) REFERENCES `fila` (`id_fila`) ON DELETE CASCADE,
  CONSTRAINT `fk_local_chamado` FOREIGN KEY (`id_local_chamado`) REFERENCES `local` (`id_local`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_resp_chamado` FOREIGN KEY (`id_usuario_responsavel_chamado`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE,
  CONSTRAINT `fk_usuario_chamado` FOREIGN KEY (`id_usuario_abertura_chamado`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;

-- Copiando estrutura para tabela db_sigat.equipamento_chamado
CREATE TABLE IF NOT EXISTS `equipamento_chamado` (
  `num_equipamento` varchar(100) DEFAULT NULL,
  `desc_equipamento` varchar(100) DEFAULT NULL,
  `id_chamado_equipamento` int(11) DEFAULT NULL,
  `status_equipamento` varchar(45) DEFAULT NULL,
  `ult_alt_equipamento` datetime DEFAULT NULL,
  KEY `fk_equipamento_chamado_idx` (`id_chamado_equipamento`),
  CONSTRAINT `fk_equipamento_chamado` FOREIGN KEY (`id_chamado_equipamento`) REFERENCES `chamado` (`id_chamado`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- Copiando estrutura para tabela db_sigat.evento
CREATE TABLE IF NOT EXISTS `evento` (
  `id_evento` int(11) NOT NULL AUTO_INCREMENT,
  `acao_evento` varchar(80) DEFAULT NULL,
  `desc_evento` varchar(120) DEFAULT NULL,
  `data_evento` datetime DEFAULT CURRENT_TIMESTAMP,
  `id_usuario_evento` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_evento`),
  KEY `fk_usuario_evento_idx` (`id_usuario_evento`),
  CONSTRAINT `fk_usuario_evento` FOREIGN KEY (`id_usuario_evento`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=264 DEFAULT CHARSET=utf8;


-- Copiando estrutura para tabela db_sigat.fila
CREATE TABLE IF NOT EXISTS `fila` (
  `id_fila` int(11) NOT NULL AUTO_INCREMENT,
  `nome_fila` varchar(45) DEFAULT NULL,
  `status_fila` varchar(45) DEFAULT NULL,
  `requer_patrimonio_fila` tinyint(4) DEFAULT '1',
  PRIMARY KEY (`id_fila`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela db_sigat.fila: ~6 rows (aproximadamente)
/*!40000 ALTER TABLE `fila` DISABLE KEYS */;
INSERT INTO `fila` (`id_fila`, `nome_fila`, `status_fila`, `requer_patrimonio_fila`) VALUES
	(1, 'Atendimento Remoto', 'ATIVO', 1),
	(2, 'Atendimento Presencial', 'ATIVO', 1),
	(3, 'Manutenção de Hardware', 'ATIVO', 1),
	(4, 'Manutenção de Rede', 'ATIVO', 0),
	(5, 'Telefonia', 'ATIVO', 0),
	(6, 'Solicitação de Equipamentos', 'ATIVO', 1);
/*!40000 ALTER TABLE `fila` ENABLE KEYS */;

-- Copiando estrutura para tabela db_sigat.interacao
CREATE TABLE IF NOT EXISTS `interacao` (
  `id_interacao` int(11) NOT NULL AUTO_INCREMENT,
  `tipo_interacao` varchar(45) DEFAULT NULL,
  `data_interacao` datetime DEFAULT CURRENT_TIMESTAMP,
  `texto_interacao` longtext,
  `id_chamado_interacao` int(11) DEFAULT NULL,
  `id_usuario_interacao` int(11) DEFAULT NULL,
  `id_fila_ant_interacao` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_interacao`),
  KEY `fk_chamado_interacao_idx` (`id_chamado_interacao`),
  KEY `fk_usuario_interacao_idx` (`id_usuario_interacao`),
  KEY `fk_fila_ant_chamado_idx` (`id_fila_ant_interacao`),
  CONSTRAINT `fk_chamado_interacao` FOREIGN KEY (`id_chamado_interacao`) REFERENCES `chamado` (`id_chamado`) ON DELETE CASCADE,
  CONSTRAINT `fk_fila_ant_chamado` FOREIGN KEY (`id_fila_ant_interacao`) REFERENCES `fila` (`id_fila`) ON DELETE CASCADE,
  CONSTRAINT `fk_usuario_interacao` FOREIGN KEY (`id_usuario_interacao`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8;


-- Copiando estrutura para tabela db_sigat.local
CREATE TABLE IF NOT EXISTS `local` (
  `id_local` int(11) NOT NULL AUTO_INCREMENT,
  `nome_local` varchar(80) DEFAULT NULL,
  `endereco_local` varchar(80) DEFAULT NULL,
  `bairro_local` varchar(45) DEFAULT NULL,
  `id_sim` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_local`)
) ENGINE=InnoDB AUTO_INCREMENT=3157 DEFAULT CHARSET=utf8;

-- Copiando estrutura para tabela db_sigat.patrimonio_chamado
CREATE TABLE IF NOT EXISTS `patrimonio_chamado` (
  `num_patrimonio` varchar(30) NOT NULL,
  `id_chamado_patrimonio` int(11) NOT NULL,
  `status_patrimonio_chamado` varchar(45) NOT NULL DEFAULT 'ABERTO',
  `status_patrimonio_chamado_ant` varchar(45) DEFAULT NULL,
  KEY `fk_chamado_patrimonio_idx` (`id_chamado_patrimonio`),
  CONSTRAINT `fk_chamado_patrimonio` FOREIGN KEY (`id_chamado_patrimonio`) REFERENCES `chamado` (`id_chamado`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- Copiando estrutura para tabela db_sigat.termo
CREATE TABLE IF NOT EXISTS `termo` (
  `id_termo` int(11) NOT NULL AUTO_INCREMENT,
  `nome_termo` varchar(45) DEFAULT NULL,
  `tipo_termo` varchar(45) DEFAULT NULL,
  `data_termo` datetime DEFAULT NULL,
  `id_chamado_termo` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_termo`),
  KEY `fk_chamado_termo_idx` (`id_chamado_termo`),
  CONSTRAINT `fk_chamado_termo` FOREIGN KEY (`id_chamado_termo`) REFERENCES `chamado` (`id_chamado`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela db_sigat.termo: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `termo` DISABLE KEYS */;
/*!40000 ALTER TABLE `termo` ENABLE KEYS */;

-- Copiando estrutura para tabela db_sigat.usuario
CREATE TABLE IF NOT EXISTS `usuario` (
  `id_usuario` int(11) NOT NULL AUTO_INCREMENT,
  `nome_usuario` varchar(50) DEFAULT NULL,
  `status_usuario` varchar(45) DEFAULT NULL,
  `data_usuario` datetime DEFAULT NULL,
  `autorizacao_usuario` int(11) DEFAULT NULL,
  `login_usuario` varchar(45) DEFAULT NULL,
  `alteracao_usuario` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `fila_usuario` int(11) DEFAULT '0',
  PRIMARY KEY (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela db_sigat.usuario: ~1 rows (aproximadamente)
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` (`id_usuario`, `nome_usuario`, `status_usuario`, `data_usuario`, `autorizacao_usuario`, `login_usuario`, `alteracao_usuario`, `fila_usuario`) VALUES
	(1, 'SISTEMA', 'INATIVO', '2021-03-22 09:56:10', 2, NULL, '2021-03-22 09:56:16', 0),
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
