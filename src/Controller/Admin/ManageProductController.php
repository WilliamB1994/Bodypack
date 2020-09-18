<?php

namespace App\Controller\Admin;

use App\Entity\Product;
use App\Form\ProductType;
use App\Repository\ProductRepository;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;


/**
 * @Route("/admin/gestion-produits")
 */
class ManageProductController extends AbstractController
{

    /**
     * @Route("/ajout-produit", name="add_product", methods={"GET","POST"})
     */
    public function addProduct(Request $request)
    {
        $product = new Product();
        $form = $this->createForm(ProductType::class, $product);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {

            //getting all data from the image uploaded
            $image = $form['image']->getData();
            $originalFilename = pathinfo($image->getClientOriginalName(), PATHINFO_FILENAME);
            // this is needed to safely include the file name as part of the URL
            $safeFilename = transliterator_transliterate('Any-Latin; Latin-ASCII; [^A-Za-z0-9_] remove; Lower()', $originalFilename);
            $newFilename = $safeFilename . '-' . uniqid() . '.' . $image->guessExtension();
            $image->move(
                //the directory file is set in config/service.yaml
                $this->getParameter('image_directory'),
                $newFilename
            );
            $newPathImage = 'assets/img/ProductImages/' . $newFilename;
            $product->setImage($newPathImage);
            $entityManager = $this->getDoctrine()->getManager();
            $entityManager->persist($product);
            $entityManager->flush();

            return $this->redirectToRoute('product_edit_list');
        }

        return $this->render('admin/manageProduct/addProduct.html.twig', [
            'product' => $product,
            'form' => $form->createView(),
        ]);
    }
    /**
     * @Route("/liste-products", name="product_edit_list")
     */
    public function listProducts(ProductRepository $productRepository): Response
    {
        return $this->render('admin/manageProduct/editProduct.html.twig', [
            'products' => $productRepository->findAll(),
        ]);
    }

    /**
     * @Route("/edit/{id}", name="product_edit",methods={"GET","POST"})
     */
    public function editProduct(Request $request, Product $product)
    {
        $form = $this->createForm(ProductType::class, $product);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {

            //getting all data from the image uploaded
            
            $image = $form['image']->getData();
            $originalFilename = pathinfo($image->getClientOriginalName(), PATHINFO_FILENAME);
            // this is needed to safely include the file name as part of the URL
            $safeFilename = transliterator_transliterate('Any-Latin; Latin-ASCII; [^A-Za-z0-9_] remove; Lower()', $originalFilename);
            $newFilename = $safeFilename . '-' . uniqid() . '.' . $image->guessExtension();
            $image->move(
                //the directory file is set in config/service.yaml
                $this->getParameter('image_directory'),
                $newFilename
            );
            $newPathImage = 'assets/img/ProductImages/' . $newFilename;
            $product->setImage($newPathImage);
            $this->getDoctrine()->getManager()->flush();
            $this->addFlash(
                'notice',
                'Le produit est a bien été modifié!'
            );

            return $this->redirectToRoute('product_edit_list');
        }

        return $this->render('product/edit_form.html.twig', [
            'product' => $product,
            'form' => $form->createView(),
        ]);
    }

    /**
     * @Route("/{id}", name="delete_products",methods={"DELETE"})
     */
    public function deleteProduct(Request $request, Product $product)
    {
        if ($this->isCsrfTokenValid('delete' . $product->getId(), $request->request->get('_token'))) {
            $entityManager = $this->getDoctrine()->getManager();
            $entityManager->remove($product);
            $entityManager->flush();
            $this->addFlash(
                'notice',
                'Le produit est a bien été supprimé!'
            );
        }
        return $this->redirectToRoute('product_edit_list');
    }

}
