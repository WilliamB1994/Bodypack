<?php

namespace App\Manager;

use Doctrine\Common\Persistence\ObjectManager;
use App\Entity\OrderProduct;
use App\Entity\Cart;
use App\Entity\User;
use App\Repository\OrderProductRepository;
use App\Repository\ProductRepository;
use App\Repository\CartRepository;

class CartManager
{
    protected $entityManager;
    protected $orderProductRepository;
    protected $productRepository;
    protected $cartRepository;

    public function __construct(ObjectManager $entityManager, OrderProductRepository $orderProductRepository, ProductRepository $productRepository, CartRepository $cartRepository)
    {
        $this->entityManager = $entityManager;
        $this->orderProductRepository = $orderProductRepository;
        $this->productRepository = $productRepository;
        $this->cartRepository = $cartRepository;
    }

    public function createInitialCart(User $user = null, int $unitPrice) : Cart
    {
        $cart = new Cart;
        $cart->setIsOrder(false);
        //if the client is logged, we save the data in the data base
        if ($user) {
            $cart->setUser($user);
        }
        $cart->setTotalAmount($unitPrice);
        $this->entityManager->persist($cart);
        $this->entityManager->flush();

        return $cart;
    }

    public function updateQuantityCart(OrderProduct $orderProduct,int $newQuantityOrderProduct, int $unitPrice)
    {
        //updating price and total amount in the cart
        $amountUpdated = $newQuantityOrderProduct * $unitPrice;

        // get all others OrderProduct in the cart to update correctly the totalAmount
        $cart = new Cart();
        $cart = $orderProduct->getCart();

        $allOtherOrderProducts = $this->orderProductRepository->findByCartExceptOne($cart, $orderProduct);
        $othersOrderProductTotalAmount = 0;

        foreach ($allOtherOrderProducts as $otherOrderProduct) {
            $othersOrderProductTotalAmount += $otherOrderProduct->getPrice();
        }
        $totalAmountUpdated = $othersOrderProductTotalAmount + $amountUpdated;

        //updating OrderProduct
        $orderProduct->setPrice($amountUpdated);
        $orderProduct->setQuantity($newQuantityOrderProduct);
        $this->entityManager->persist($orderProduct);

        //updating the cart's total amount 
        $cart->setTotalAmount($totalAmountUpdated);
        $this->entityManager->persist($cart);
        $this->entityManager->flush();
    }

    public function showQuantityTotal(Cart $cart = null) : int
    {
        $listOrderProduct = $this->orderProductRepository->findBy(['cart' => $cart]);
        $quantityOrder = 0;
        foreach ($listOrderProduct as $orderProduct) {
            $quantityOrder += $orderProduct->getQuantity();
        }
        return $quantityOrder;
    }

    public function showCart(User $user = null, $dataStoredInCookie) : array
    {
        //if a user if logged, first we check if he has a cart in progress stored in database
        if ($user) {
            $cart = $this->cartRepository->findOneBy(['user' => $user, 'isOrder' => '0']);
            if ($cart) {
                $idproductCategoriesFirstProductSelected = $cart->getOrderProducts()[0]->getProduct()->getproductCategories();
                $productsListMayInterested = $this->productRepository->findByRelatedProducts($idproductCategoriesFirstProductSelected);
            } else {
                //if not, we check if the user has a cart stored in a cookie
                $cart = $this->cartRepository->find($dataStoredInCookie);
                if ($cart) {
                    $idproductCategoriesFirstProductSelected = $cart->getOrderProducts()[0]->getProduct()->getproductCategories();
                    $productlsListMayInterested = $this->productRepository->findByRelatedProducts($idproductCategoriesFirstProductSelected);
                } else {
                    $productsListMayInterested = $this->productRepository->findByLastProducts(4);
                }
            }
        } else {
            //if the visitor is not logged, we check if a cart is stored in a cookie
           
            if (!empty($dataStoredInCookie)) {
                $cart = $this->cartRepository->find($dataStoredInCookie);
                $idproductCategoriesFirstProductSelected = $cart->getOrderProducts()[0]->getProduct()->getproductCategories();
                $productsListMayInterested = $this->productRepository->findByRelatedProducts($idproductCategoriesFirstProductSelected);
            } else {
                $cart= null;
                $productsListMayInterested = $this->productRepository->findByLastProducts(4);
            };
        }
        return [$cart, $productsListMayInterested];
    }

    public function persistingUpdateTotalAmount(Cart $cart, int $productPrice)
    {
        $newAmmount = $cart->getTotalAmount() + $productPrice;
        $cart->setTotalAmount($newAmmount);
        $this->entityManager->persist($cart);
    }
}
