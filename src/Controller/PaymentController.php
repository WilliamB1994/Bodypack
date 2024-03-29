<?php

namespace App\Controller;

use App\Entity\Orders;
use App\Entity\Product;
use App\Manager\SessionManager;
use App\Repository\OrderProductRepository;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;

class PaymentController extends AbstractController
{
    /**
     * @Route("/paiement/{id}", name="payment", methods={"POST", "GET"})
     */
    public function paymentForm(Orders $order)
    {
        $amount = $order->getTotalAmount() * 100;
        \Stripe\Stripe::setApiKey('sk_test_bfHv9DFUb0tj17UHOsD63dks00IUrgmQ30');

        $intent = \Stripe\PaymentIntent::create([
            'amount' => $amount,
            'currency' => 'eur',
            'payment_method_types' => ['card'],
            'metadata' => ['order_id' => $order->getId()],
        ]);

        return $this->render('payment/index.html.twig', [
            'controller_name' => 'PaymentController',
            'order' => $order,
            'clientPayment' => $intent->client_secret
        ]);
    }

    /**
     * @Route("/confirmation/{id}", name="payment_confirmation", methods={"POST", "GET"})
     */
    public function paymentConfirmation(Orders $order, OrderProductRepository $orderProductRepository, SessionManager $sessionManager, \Swift_Mailer $mailer)
    {
        $entityManager = $this->getDoctrine()->getManager();
        $cart = $order->getCart();
        $order->setStatus("paid");
        $entityManager->persist($order);

        //Deleting in the database all products selected and link to the cart
        //also updating the available quantity stock for each purchased product 

        $arrayOfOrderProduct = $orderProductRepository->findByCart($cart);
        foreach ($arrayOfOrderProduct as $orderProduct) {
            $quantityOrder = $orderProduct->getQuantity();
            $product = new Product();
            $product = $orderProduct->getProduct();
            $quantityProductStock = $product->getQuantityStock();
            $newQuantityStock = $quantityProductStock - $quantityOrder;
            $product->setQuantityStock($newQuantityStock);
            $cart->removeOrderProduct($orderProduct);
        }

        $entityManager->flush();
        //Deleteing the cart stored in the session
        $sessionManager->delete();

        //create the email with all the variables about the customer
        
        $message = (new \Swift_Message('Confirmation de commande | Bodypack'))
            ->setFrom('bruel.william@gmail.com')
            ->setTo($order->getClient()->getEmail())
            ->setBody(
                $this->renderView(
                    'email/confirmation.html.twig',
                    [   
                        'name' => $order->getClient()->getFirstname(),
                        'date'=>$order->getOrderDate(),
                        'orderId'=>$order->getId(),
                        'totalAmount' => $order->getTotalAmount()
                    ]
                ),
                'text/html'
            );  
        $mailer->send($message);


        return $this->render('payment/confirmation.html.twig');
    }
}
