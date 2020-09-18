<?php

namespace App\Entity;

use Symfony\Component\Validator\Constraints as Assert;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity(repositoryClass="App\Repository\ProductRepository")
 */
class Product
{
    /**
     * @ORM\Id()
     * @ORM\GeneratedValue()
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @ORM\Column(type="string", length=255)     
     * @Assert\Type(
     *     type="string",
     *     message="La valeur doit être une chaîne de caractères."
     * )
     */
    private $title;

    /**
     * @ORM\Column(type="text", nullable=true)
     * @Assert\Type(
     *     type="string",
     *     message="La valeur doit être une chaîne de caractères."
     * )
     */

    private $description;

    /**
     * @ORM\Column(type="integer")
     */
    private $ean;

    /**
     * @ORM\Column(type="integer")
     */
    private $sku;

    /**
     * @ORM\Column(type="integer")
     * @Assert\GreaterThanOrEqual(
     *  value = 0,
     *  message = "La quantité doit être supérieur ou égal à O."
     * )
     */
    private $quantity_stock;

    /**
     * @ORM\Column(type="integer")
     * @Assert\GreaterThanOrEqual(
     *  value = 1,
     *  message = "Le prix du produit ne peut être inférieur à 1€."
     * )
     */
    private $regularPrice;

    /**
     * @ORM\Column(type="integer", nullable=true)
     * @Assert\GreaterThanOrEqual(
     *  value = 0,
     *  message = "Le prix du produit ne peut être inférieur à 0€."
     * )
     * @Assert\Expression(
     *     "this.getReducePrice() < this.getRegularPrice()",
     *     message="Le prix réduit doit être inférieur au prix standard."
     *  )
     */
    private $reducePrice;

    /**
     * @ORM\Column(type="string", length=255)
     */
    private $image;

    /**
     * @ORM\ManyToOne(targetEntity="App\Entity\ProductCategories", inversedBy="products")
     * @ORM\JoinColumn(nullable=false)
     */
    private $productCategories;

    /**
     * @ORM\OneToMany(targetEntity="App\Entity\OrderProduct", mappedBy="product")
     */
    private $orderProducts;

    public function __construct()
    {
        $this->orderProducts = new ArrayCollection();
    }


    public function getId(): ?int
    {
        return $this->id;
    }

    public function getTitle(): ?string
    {
        return $this->title;
    }

    public function setTitle(string $title): self
    {
        $this->title = $title;

        return $this;
    }

    public function getDescription(): ?string
    {
        return $this->description;
    }

    public function setDescription(string $description): self
    {
        $this->description = $description;

        return $this;
    }

    public function getEan(): ?int
    {
        return $this->ean;
    }

    public function setEan(int $ean): self
    {
        $this->ean = $ean;

        return $this;
    }

    public function getSku(): ?int
    {
        return $this->sku;
    }

    public function setSku(int $sku): self
    {
        $this->sku = $sku;

        return $this;
    }

    public function getQuantityStock(): ?int
    {
        return $this->quantity_stock;
    }

    public function setQuantityStock(?int $quantity_stock): self
    {
        $this->quantity_stock = $quantity_stock;

        return $this;
    }

    public function getRegularPrice(): ?int
    {
        return $this->regularPrice;
    }

    public function setRegularPrice(int $regularPrice): self
    {
        $this->regularPrice = $regularPrice;

        return $this;
    }

    public function getReducePrice(): ?int
    {
        return $this->reducePrice;
    }

    public function setReducePrice(?int $reducePrice): self
    {
        $this->reducePrice = $reducePrice;

        return $this;
    }

    public function getImage(): ?string
    {
        return $this->image;
    }

    public function setImage(string $image): self
    {
        $this->image = $image;

        return $this;
    }

    public function getProductCategories(): ?ProductCategories
    {
        return $this->productCategories;
    }

    public function setProductCategories(?ProductCategories $productCategories): self
    {
        $this->productCategories = $productCategories;

        return $this;
    }

    /**
     * @return Collection|OrderProduct[]
     */
    public function getOrderProducts(): Collection
    {
        return $this->orderProducts;
    }

    public function addOrderProduct(OrderProduct $orderProduct): self
    {
        if (!$this->orderProducts->contains($orderProduct)) {
            $this->orderProducts[] = $orderProduct;
            $orderProduct->setProduct($this);
        }

        return $this;
    }

    public function removeOrderProduct(OrderProduct $orderProduct): self
    {
        if ($this->orderProducts->contains($orderProduct)) {
            $this->orderProducts->removeElement($orderProduct);
            // set the owning side to null (unless already changed)
            if ($orderProduct->getProduct() === $this) {
                $orderProduct->setProduct(null);
            }
        }

        return $this;
    }

}
