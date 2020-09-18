<?php

namespace App\Repository;

use App\Entity\Product;
use Doctrine\ORM\Query;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Common\Persistence\ManagerRegistry;

/**
 * @method Product|null find($id, $lockMode = null, $lockVersion = null)
 * @method Product|null findOneBy(array $criteria, array $orderBy = null)
 * @method Product[]    findAll()
 * @method Product[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class ProductRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Product::class);
    }

    // /**
    //  * @return Query
    //  */
    public function findAllQuery(): Query
    {
        return $this->createQueryBuilder('u')
            ->orderBy('u.id', 'DESC')
            ->getQuery();
    }

    public function finByProductCategoriesQuery($value): Query
    {
        return $this->createQueryBuilder('u')
            ->andWhere('u.productCategories = :val')
            ->setParameter('val', $value)
            ->orderBy('u.id', 'DESC')
            ->getQuery();
    }



    public function findAllProductPromoQuery(): Query
    {
        return $this->createQueryBuilder('v')
            ->andWhere('v.reducePrice > 0')
            ->orderBy('v.id', 'ASC')
            ->getQuery();
    }
    // /**
    //  * @return Product[] Returns an array of Product objects
    //  */
    public function findByLastProducts($value)
    {
        return $this->createQueryBuilder('u')
            ->orderBy('u.id', 'DESC')
            ->setMaxResults($value)
            ->getQuery()
            ->getResult();
    }

    public function findByRelatedProducts($value)
    {
        return $this->createQueryBuilder('u')
            ->orderBy('u.id', 'DESC')
            ->andWhere('u.productCategories = :val')
            ->setParameter('val', $value)
            ->setMaxResults(4)
            ->getQuery()
            ->getResult();
    }

    // /**
    //  * @return Product[] Returns an array of Product objects
    //  */
    /*
    public function findByExampleField($value)
    {
        return $this->createQueryBuilder('p')
            ->andWhere('p.exampleField = :val')
            ->setParameter('val', $value)
            ->orderBy('p.id', 'ASC')
            ->setMaxResults(10)
            ->getQuery()
            ->getResult()
        ;
    }
    */

    /*
    public function findOneBySomeField($value): ?Product
    {
        return $this->createQueryBuilder('p')
            ->andWhere('p.exampleField = :val')
            ->setParameter('val', $value)
            ->getQuery()
            ->getOneOrNullResult()
        ;
    }
    */
}
