<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20200916225138 extends AbstractMigration
{
    public function getDescription() : string
    {
        return '';
    }

    public function up(Schema $schema) : void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->abortIf($this->connection->getDatabasePlatform()->getName() !== 'mysql', 'Migration can only be executed safely on \'mysql\'.');

        $this->addSql('ALTER TABLE order_product DROP FOREIGN KEY FK_2530ADE63FFFF645');
        $this->addSql('ALTER TABLE track DROP FOREIGN KEY FK_D6E3F8A63FFFF645');
        $this->addSql('DROP TABLE track');
        $this->addSql('DROP TABLE vinyl');
        $this->addSql('ALTER TABLE cart CHANGE user_id user_id INT DEFAULT NULL');
        $this->addSql('ALTER TABLE client CHANGE user_id user_id INT DEFAULT NULL, CHANGE adress_complement adress_complement VARCHAR(255) DEFAULT NULL');
        $this->addSql('DROP INDEX IDX_2530ADE63FFFF645 ON order_product');
        $this->addSql('ALTER TABLE order_product DROP vinyl_id');
        $this->addSql('ALTER TABLE orders CHANGE user_id user_id INT DEFAULT NULL');
        $this->addSql('ALTER TABLE product CHANGE reduce_price reduce_price INT DEFAULT NULL');
        $this->addSql('ALTER TABLE product_categories CHANGE image image VARCHAR(255) DEFAULT NULL');
    }

    public function down(Schema $schema) : void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->abortIf($this->connection->getDatabasePlatform()->getName() !== 'mysql', 'Migration can only be executed safely on \'mysql\'.');

        $this->addSql('CREATE TABLE track (id INT AUTO_INCREMENT NOT NULL, vinyl_id INT NOT NULL, name VARCHAR(255) NOT NULL COLLATE utf8mb4_unicode_ci, duration DOUBLE PRECISION NOT NULL, position VARCHAR(255) NOT NULL COLLATE utf8mb4_unicode_ci, INDEX IDX_D6E3F8A63FFFF645 (vinyl_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB COMMENT = \'\' ');
        $this->addSql('CREATE TABLE vinyl (id INT AUTO_INCREMENT NOT NULL, genre_id INT NOT NULL, name VARCHAR(255) NOT NULL COLLATE utf8mb4_unicode_ci, artiste VARCHAR(255) NOT NULL COLLATE utf8mb4_unicode_ci, label VARCHAR(255) NOT NULL COLLATE utf8mb4_unicode_ci, cat_num VARCHAR(255) NOT NULL COLLATE utf8mb4_unicode_ci, format VARCHAR(255) NOT NULL COLLATE utf8mb4_unicode_ci, country VARCHAR(255) NOT NULL COLLATE utf8mb4_unicode_ci, year INT NOT NULL, media_condition VARCHAR(255) NOT NULL COLLATE utf8mb4_unicode_ci, sleeve_condition VARCHAR(255) NOT NULL COLLATE utf8mb4_unicode_ci, quantity_stock INT NOT NULL, regular_price INT NOT NULL, reduce_price INT DEFAULT NULL, cover VARCHAR(255) NOT NULL COLLATE utf8mb4_unicode_ci, description LONGTEXT DEFAULT NULL COLLATE utf8mb4_unicode_ci, INDEX IDX_E2E531D4296D31F (genre_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB COMMENT = \'\' ');
        $this->addSql('ALTER TABLE track ADD CONSTRAINT FK_D6E3F8A63FFFF645 FOREIGN KEY (vinyl_id) REFERENCES vinyl (id)');
        $this->addSql('ALTER TABLE vinyl ADD CONSTRAINT FK_E2E531D4296D31F FOREIGN KEY (genre_id) REFERENCES genre (id)');
        $this->addSql('ALTER TABLE cart CHANGE user_id user_id INT DEFAULT NULL');
        $this->addSql('ALTER TABLE client CHANGE user_id user_id INT DEFAULT NULL, CHANGE adress_complement adress_complement VARCHAR(255) DEFAULT \'NULL\' COLLATE utf8mb4_unicode_ci');
        $this->addSql('ALTER TABLE order_product ADD vinyl_id INT DEFAULT NULL');
        $this->addSql('ALTER TABLE order_product ADD CONSTRAINT FK_2530ADE63FFFF645 FOREIGN KEY (vinyl_id) REFERENCES vinyl (id)');
        $this->addSql('CREATE INDEX IDX_2530ADE63FFFF645 ON order_product (vinyl_id)');
        $this->addSql('ALTER TABLE orders CHANGE user_id user_id INT DEFAULT NULL');
        $this->addSql('ALTER TABLE product CHANGE reduce_price reduce_price INT DEFAULT NULL');
        $this->addSql('ALTER TABLE product_categories CHANGE image image VARCHAR(255) DEFAULT \'NULL\' COLLATE utf8mb4_unicode_ci');
    }
}
