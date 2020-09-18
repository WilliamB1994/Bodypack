<?php

namespace App\Manager;

use Doctrine\Common\Persistence\ObjectManager;
use App\Entity\Product;


class ProductManager
{

    public function __construct(ObjectManager $entityManager)
    {
        $this->entityManager = $entityManager;
    }

    public function getUnitPrice(Product $product)
    {

        $productReducePrice = $product->getReducePrice();
        if (empty($productReducePrice) || $productReducePrice === 0) {
            $unitPrice = $product->getRegularPrice();
        } else {
            $unitPrice = $productReducePrice;
        }
        return $unitPrice;
    }
}