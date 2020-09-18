<?php

namespace App\Controller\Admin;

use App\Repository\UserRepository;
use App\Repository\ProductRepository;
use App\Repository\OrdersRepository;
use App\Repository\TrackRepository;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\File\UploadedFile;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;


/**
 * @Route("/admin")
 */
class AdminController extends AbstractController
{
    /**
     * @Route("/", name="admin")
     */
    public function index(OrdersRepository $ordersRepository, UserRepository $userRepository, ProductRepository $productRepository)
    {

        //getting the sales revenus of the web store
        $listOrdersPaid = $ordersRepository->findAllStatus('paid');
        $salesRevenue = 0;
        foreach ($listOrdersPaid as $order) {
          $salesRevenue = $salesRevenue + $order->getTotalAmount();
        }

        $numberOfOrders = $ordersRepository->findAll();
        $numberOfUsers = $userRepository->findAll();
        $numberOfProducts = $productRepository->findAll();

        return $this->render('admin/index.html.twig', [
            'controller_name' => 'AdminController',
            'salesRevenue' => $salesRevenue,
            'numberOfUsers' => count($numberOfUsers),
            'numberOfProducts' => count($numberOfProducts),
            'numberOfOrders' => count($numberOfOrders),
        ]);
    }

}
