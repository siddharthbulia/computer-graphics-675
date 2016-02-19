
#include <stdrsl/ShadingContext.h> // for ShadingUtils
#include <stdrsl/AreaSampler.h>
#include <stdrsl/SampleMgrPathTrace.h>
class geolight (float intensity = 1;
                color lightColor = 1;
                float finalOpacity = 1)
{
    public void prelighting (output color Ci, Oi)
    {
        color emission = intensity * lightColor;
        Oi = finalOpacity;
        emit(emission, "cosinepower", 10, "specularcontribution", 0, "diffusecontribution", 100);
        Ci = emission;
    }

    public void surface(output color Ci, Oi) {
        Ci = intensity * lightColor;
        Oi = finalOpacity;
    }
    public void generatePhoton(output point origin; output vector direction;
                           output color power; output float pdf)
    {
      // Use stdrsl_AreaSampler to generate a photon origin, direction,
      // texture sample coordinates, and light source area
      stdrsl_AreaSampler sampler;
      float ss, tt, lightarea;
      sampler->generatePhoton("disc", 1,
                              origin, direction, ss, tt, lightarea);

      color lc = intensity * lightColor;

      // Compute power of light source and assign pdf
      power = lc * lightarea;
      pdf = intensity * lightarea;
    }
}