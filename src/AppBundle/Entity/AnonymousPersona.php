<?php

namespace AppBundle\Entity;

use AppBundle\Entity\Attribute\Accessor;
use Ds\Component\Security\Model\Type\Secured;
use Knp\DoctrineBehaviors\Model as Behavior;

use ApiPlatform\Core\Annotation\ApiResource;
use ApiPlatform\Core\Annotation\ApiProperty;
use Doctrine\ORM\Mapping as ORM;
use Symfony\Bridge\Doctrine\Validator\Constraints as ORMAssert;
use Symfony\Component\Serializer\Annotation As Serializer;
use Symfony\Component\Validator\Constraints as Assert;

/**
 * Class AnonymousPersona
 *
 * @ApiResource(
 *      attributes={
 *          "normalization_context"={
 *              "groups"={"persona_output"}
 *          },
 *          "denormalization_context"={
 *              "groups"={"persona_input"}
 *          },
 *          "filters"={
 *              "app.anonymous_persona.search",
 *              "app.anonymous_persona.date",
 *              "app.anonymous_persona.order",
 *              "app.anonymous_persona.search_translation"
 *          }
 *      }
 * )
 * @ORM\Entity(repositoryClass="AppBundle\Repository\AnonymousPersonaRepository")
 * @ORM\Table(name="app_anonymous_persona")
 * @ORM\Cache(usage="NONSTRICT_READ_WRITE")
 * @ORMAssert\UniqueEntity(fields="uuid")
 */
class AnonymousPersona extends Persona implements Secured
{
    // This behavior must be included at the same level as the child class.
    use Behavior\Translatable\Translatable;

    use Accessor\Anonymous;

    /**
     * @var \AppBundle\Entity\Anonymous
     * @ApiProperty
     * @Serializer\Groups({"persona_output", "persona_input"})
     * @ORM\ManyToOne(targetEntity="AppBundle\Entity\Anonymous", inversedBy="personas")
     * @ORM\JoinColumn(name="anonymous_id", referencedColumnName="id")
     * @ORM\Cache(usage="NONSTRICT_READ_WRITE")
     * @Assert\Valid
     */
    protected $anonymous;
}