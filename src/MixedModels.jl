module MixedModels

using BlockArrays
using Distributions
using Feather
using GLM
using LinearAlgebra
using NamedArrays
using NLopt
using Random
using Pkg.Artifacts
using PooledArrays
using ProgressMeter
using SparseArrays
using StaticArrays
using Statistics
using StatsBase
using StatsModels
using Tables

using LinearAlgebra: BlasFloat, BlasReal, HermOrSym, PosDefException, copytri!
using Base: Ryu
using GLM: Link, canonicallink

using StatsFuns: log2π, normccdf

import Base: *
import GLM: dispersion, dispersion_parameter
import NLopt: Opt
import StatsBase: fit, fit!

export @formula,
       Bernoulli,
       Binomial,
       Block,
       BlockDescription,
       BlockedSparse,
       DummyCoding,
       EffectsCoding,
       Grouping,
       Gamma,
       GeneralizedLinearMixedModel,
       HelmertCoding,
       HypothesisCoding,
       InverseGaussian,
       InverseLink,
       LinearMixedModel,
       LogitLink,
       LogLink,
       MixedModel,
       MixedModelBootstrap,
       Normal,
       OptSummary,
       Poisson,
       RaggedArray,
       RandomEffectsTerm,
       ReMat,
       SeqDiffCoding,
       SqrtLink,
       UniformBlockDiagonal,
       VarCorr,

       aic,
       aicc,
       bic,
       coef,
       coefnames,
       coefpvalues,
       coeftable,
       cond,
       condVar,
       describeblocks,
       deviance,
       dispersion,
       dispersion_parameter,
       dof,
       dof_residual,
       fit,
       fit!,
       fitted,
       fixef,
       fixefnames,
       fulldummy,
       fnames,
       GHnorm,
       issingular,
       leverage,
       logdet,
       loglikelihood,
       lowerbd,
       nobs,
       objective,
       parametricbootstrap,
       pirls!,
       predict,
       pwrss,
       ranef,
       raneftables,
       rank,
       refit!,
       replicate,
       residuals,
       response,
       shortestcovint,
       sdest,
       setθ!,
       simulate!,
       sparse,
       std,
       stderror,
       updateL!,
       varest,
       vcov,
       zerocorr,
       zerocorr!

import Base: ==, *

"""
    MixedModel

Abstract type for mixed models.  MixedModels.jl implements two subtypes:
`LinearMixedModel` and `GeneralizedLinearMixedModel`.  See the documentation for
each for more details.

This type is primarily used for dispatch in `fit`.  Without a distribution and
link function specified, a `LinearMixedModel` will be fit.  When a
distribution/link function is provided, a `GeneralizedLinearModel` is fit,
unless that distribution is `Normal` and the link is `IdentityLink`, in which
case the resulting GLMM would be equivalent to a `LinearMixedModel` anyway and
so the simpler, equivalent `LinearMixedModel` will be fit instead.
"""
abstract type MixedModel{T} <: StatsModels.RegressionModel end # model with fixed and random effects

function __init__()
    global TestData = artifact"TestData"
end

include("utilities.jl")
include("arraytypes.jl")
include("varcorr.jl")
include("femat.jl")
include("remat.jl")
include("optsummary.jl")
include("schema.jl")
include("randomeffectsterm.jl")
include("linearmixedmodel.jl")
include("gausshermite.jl")
include("generalizedlinearmixedmodel.jl")
include("mixedmodel.jl")
include("likelihoodratiotest.jl")
include("linalg/pivot.jl")
include("linalg/cholUnblocked.jl")
include("linalg/rankUpdate.jl")
include("linalg/logdet.jl")
include("linalg.jl")
include("simulate.jl")
include("bootstrap.jl")
include("blockdescription.jl")
include("grouping.jl")

end # module
