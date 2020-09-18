<?php

namespace App\Controller;


use App\Entity\Product;
use App\Form\ProductType;
use App\Manager\CartManager;
use App\Manager\OrderProductManager;
use App\Manager\SessionManager;
use App\Manager\ProductManager;
use App\Repository\CartRepository;
use App\Repository\ProductCategoriesRepository;
use App\Repository\ProductRepository;
use App\Repository\OrderProductRepository;
use Knp\Component\Pager\PaginatorInterface;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\Security\Core\User\UserInterface;

/**
 * @Route("/product")
 */
class ProductController extends AbstractController
{
    /**
     * @Route("/", name="product_index", methods={"GET"}),
     */
    public function index(ProductRepository $productRepository, PaginatorInterface $paginator, ProductCategoriesRepository $productcategoriesRepository, Request $request): Response
    {

        //we show products by categories
        if ($request->query->get('category')) {
            $idProductCategories = $request->query->get('category');
            $productsFiltredByProductCategories = $paginator->paginate(
                $productRepository->finByProductCategoriesQuery($idProductCategories),
                $request->query->getInt('page', 1),
                8
            );
            return $this->render('product/index.html.twig', [
                'products' => $productsFiltredByProductCategories,
                'productcategories' => $productcategoriesRepository->findAll()
            ]);
        };
        $allproducts = $paginator->paginate(
            $productRepository->findAllQuery(),
            $request->query->getInt('page', 1),
            8
        );
        $numberAllProducts = $allproducts->getTotalItemCount();
        return $this->render('product/index.html.twig', [
            'products' => $allproducts,
            'numberAllProducts' => $numberAllProducts,
            'productcategories' => $productcategoriesRepository->findAll()
        ]);
    }

    /**
     * @Route("/promo", name="product_promo", methods={"GET"})
     */
    public function promo(ProductRepository $productRepository, PaginatorInterface $paginator, Request $request): Response
    {
        $productsPromo = $paginator->paginate(
            $productRepository->findAllProductPromoQuery(),
            $request->query->getInt('page', 1),
            8
        );
        return $this->render('product/promo.html.twig', [
            'products' => $productsPromo,
        ]);
    }

    /**
     * @Route("/maternelle", name="product_maternelle", methods={"GET"})
     */
    public function maternelle(ProductRepository $productRepository, PaginatorInterface $paginator, Request $request): Response
    {
        $productsMaternelle = $paginator->paginate(
            $productRepository->finByProductCategoriesQuery('1'),
            $request->query->getInt('page', 1),
            8
        );
        return $this->render('product/maternelle.html.twig', [
            'products' => $productsMaternelle,
        ]);
    }

    /**
     * @Route("/primaire", name="product_primaire", methods={"GET"})
     */
    public function primaire(ProductRepository $productRepository, PaginatorInterface $paginator, Request $request): Response
    {
        $productsPrimaire = $paginator->paginate(
            $productRepository->finByProductCategoriesQuery('2'),
            $request->query->getInt('page', 1),
            8
        );
        return $this->render('product/primaire.html.twig', [
            'products' => $productsPrimaire,
        ]);
    }

    /**
     * @Route("/secondaire", name="product_secondaire", methods={"GET"})
     */
    public function secondaire(ProductRepository $productRepository, PaginatorInterface $paginator, Request $request): Response
    {
        $productsSecondaire = $paginator->paginate(
            $productRepository->finByProductCategoriesQuery('4'),
            $request->query->getInt('page', 1),
            8
        );
        return $this->render('product/secondaire.html.twig', [
            'products' => $productsSecondaire,
        ]);
    }

    /**
     * @Route("/sport", name="product_sport", methods={"GET"})
     */
    public function sport(ProductRepository $productRepository, PaginatorInterface $paginator, Request $request): Response
    {
        $productsSport = $paginator->paginate(
            $productRepository->finByProductCategoriesQuery('6'),
            $request->query->getInt('page', 1),
            8
        );
        return $this->render('product/sport.html.twig', [
            'products' => $productsSport,
        ]);
    }

    /**
     * @Route("/business", name="product_business", methods={"GET"})
     */
    public function business(ProductRepository $productRepository, PaginatorInterface $paginator, Request $request): Response
    {
        $productsBusiness = $paginator->paginate(
            $productRepository->finByProductCategoriesQuery('8'),
            $request->query->getInt('page', 1),
            8
        );
        return $this->render('product/business.html.twig', [
            'products' => $productsBusiness,
        ]);
    }

    /**
     * @Route("/new", name="product_new", methods={"GET","POST"})
     */
    public function new(Request $request): Response
    {
        $product = new Product();
        $form = $this->createForm(ProductType::class, $product);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $entityManager = $this->getDoctrine()->getManager();
            $entityManager->persist($product);
            $entityManager->flush();

            return $this->redirectToRoute('product_index');
        }

        return $this->render('product/new.html.twig', [
            'product' => $product,
            'form' => $form->createView(),
        ]);
    }

    /**
     * @Route("/{id}", name="product_show", methods={"GET","POST"})
     */
    public function show(SessionManager $sessionManager, UserInterface $user = null, Product $product, ProductRepository $productRepository, CartRepository $cartRepository, OrderProductRepository $orderProductRepository, Request $request, ProductManager $productManager, OrderProductManager $orderProductManager, CartManager $cartManager): Response
    {
        
        $productRelated = $productRepository->findByRelatedProducts($product->getProductCategories()->getId());


        //if the customer click on 'add to cart', we create a new entry in OrderProduct and a new Cart
        if ($request->request->get('productSelected')) {

            // we check if the product as a discount and we store the price
            $productPrice = $productManager->getUnitPrice($product);
            // we check if the customer have already an cart in progress (id stored in the session)
            if (!empty($sessionManager->getCartSession())) {

                $cartInProgress = $cartRepository->find($sessionManager->getCartSession());
                // we check if the cart in progress doesn't have already the product selected
                $cartWithProductAlreadySelected = $orderProductRepository->findOneBy(['cart' => $cartInProgress, 'product' => $product]);

                if ($cartWithProductAlreadySelected) {
                    $this->addFlash(
                        'notice',
                        'Le produit est déjà dans votre panier!'
                    );
                    return $this->render('product/show.html.twig', [
                        'product' => $product,
                        'relatedProducts' => $productRelated
                    ]);
                }
                //calculating the new ammount of the cart
                $cartManager->persistingUpdateTotalAmount($cartInProgress, $productPrice);

                //creating a new order Product 
                $orderProductManager->createOrderProduct($product, $cartInProgress, $productPrice);
                $this->addFlash(
                    'notice',
                    'Le produit a bien été ajouté au panier!'
                );
                return $this->render('product/show.html.twig', [
                    'product' => $product,
                    'relatedProducts' => $productRelated
                ]);
            }

            //creating a new Cart and we save the cart Id in the session
            $cart = $cartManager->createInitialCart($user, $productPrice);
            $sessionManager->create($cart->getId());

            //creating a new Order Product
            $orderProductManager->createOrderProduct($product, $cart, $productPrice);

            $this->addFlash(
                'notice',
                'Le produit a bien été ajouté au panier!'
            );
        }
        return  $this->render('product/show.html.twig', [
            'product' => $product,
            'relatedProducts' => $productRelated
        ]);
    }
}
