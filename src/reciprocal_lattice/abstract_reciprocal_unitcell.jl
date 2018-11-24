################################################################################
#
#	ABSTRACT TYPE
#
#   ReciprocalUnitcell{P,B} <: Unitcell{P,B}
#   --> P is the reciprocal site type (<: AbstractReciprocalPoint{D})
#       --> D is the dimension of embedding space
#   --> B is the bond type (<: AbstractBond{L,N})
#       --> N is the dimension of the Bravais lattice that the bond is located in
#       --> L is the label type of bonds
#
#   FILE CONTAINS
#       - abstract type definition
#       - interface definition
#       - TODO interface testing
#
################################################################################

################################################################################
#
#   ABSTRACT TYPE DEFINITION
#
################################################################################
abstract type AbstractReciprocalUnitcell{
        P <: AbstractReciprocalPoint{D} where {D},
        B <: AbstractBond{L,N} where {L,N}
    } <: AbstractUnitcell{P,B} end

# export the type
export AbstractReciprocalUnitcell






################################################################################
#
#	INTERFACING / ACCESSING UNITCELLS
#	(functions that are overwritten by abstract reciprocal type, NOT concrete)
#
################################################################################


# default constructor interface
# used for creation of new unitcells
function newUnitcell(
            ::Type{U},
            lattice_vectors :: Vector{<:Vector{<:Real}},
            sites           :: Vector{S},
            bonds           :: Vector{B}
        ) :: U where {D,N,L,S<:AbstractReciprocalPoint{D},B<:AbstractBond{L,N},U<:AbstractReciprocalUnitcell{S,B}}

    # check if only a single site is given
    @assert length(sites) == 1
    # check if the site is located at 0
    @assert sum(abs.(point(sites[1]))) < 1e-8

    # pass to the reciprocal unitcell constructor interface
    return newReciprocalUnitcell(U, lattice_vectors, bonds)
end

# export the newUnitcell interface
export newUnitcell







################################################################################
#
#	INTERFACING / ACCESSING RECIPROCAL UNITCELLS
#	(functions that have to be overwritten by concrete types)
#
################################################################################

# constructor
function newReciprocalUnitcell(
            ::Type{R},
            lattice_vectors :: Vector{<:Vector{<:Real}},
            bonds           :: Vector{B}
        ) :: R where {D,N,L,P<:AbstractReciprocalPoint{D}, B<:AbstractBond{N,L}, R<:AbstractReciprocalUnitcell{P,B}}

    # throw an error because implementation for concrete type is missing
    error(  "not implemented function 'newReciprocalUnitcell' for concrete reciprocal unitcell type " *
            string(R) * " with bond type " * string(B) )
end
