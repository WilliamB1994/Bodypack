<?php

namespace App\Controller;

use App\Repository\ProductRepository;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;

class HomeController extends AbstractController
{
    /**
     * @Route("/", name="home")
     */
    public function index(ProductRepository $productlRepository): Response
    {
        //custom querry created in the repository to get only 4 last products
        $lastProducts = $productlRepository->findByLastProducts(4);
        return $this->render('home/index.html.twig', [
            'controller_name' => 'HomeController',
            'products' => $lastProducts
        ]);
    }
    /** 
     * @Route("/contact", name="contact", methods={"POST", "GET"})
     */
    public function contact(Request $request, \Swift_Mailer $mailer)
    {
        if ($request->getMethod() === "POST") {

            //send the messga eto the administrator of the website

            $message = (new \Swift_Message('Message contact | Bodypack'))
            ->setFrom('contact@bruelwilliam.com')
            ->setTo('bruel.william@gmail.com')
            ->setBody(
                $this->renderView(
                    'email/contact.html.twig',
                    [   
                        'firstname' => $request->request->get('firstname'),
                        'lastname'=>$request->request->get('lastname'),
                        'phone'=>$request->request->get('phone'),
                        'email'=>$request->request->get('email'),
                        'message' => $request->request->get('message')
                    ]
                ),
                'text/html'
            );  

        $mailer->send($message);




            $this->addFlash(
                'notice',
                'Merci! Votre message a bien été envoyé, l\'équipe de Bodypack vous contactera dans les plus brefs délais!'
            );
        }
       
        return $this->render('contact/index.html.twig', []);
    }
    /** 
     * @Route("/mentions", name="mentions")
     */
    public function mentions()
    {
        return $this->render('mentionsLegales/index.html.twig', []);
    }

    /** 
     * @Route("/brand", name="brand")
     */
    public function brand()
    {
        return $this->render('brand/index.html.twig', []);
    }

    /** 
     * @Route("/warranty", name="warranty")
     */
    public function warranty()
    {
        return $this->render('warranty/index.html.twig', []);
    }
}
