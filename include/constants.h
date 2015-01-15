#ifndef CONSTANTS_H_GUARD
#define CONSTANTS_H_GUARD

/* SCS VERSION NUMBER ----------------------------------------------    */
#define SCS_VERSION ("1.1.0")

/* SCS returns one of the following integers: (zero never returned)     */
#define SCS_SIGINT          (-5)
#define SCS_FAILURE         (-4)
#define SCS_INDETERMINATE   (-3)
#define SCS_INFEASIBLE      (-2) /* primal infeasible, dual unbounded   */
#define SCS_UNBOUNDED       (-1) /* primal unbounded, dual infeasible   */
#define SCS_SOLVED          (1)

/* DEFAULT SOLVER PARAMETERS AND SETTINGS --------------------------    */
#define MAX_ITERS       (2500)
#define EPS             (1E-3)
#define ALPHA           (1.5)
#define RHO_X           (1E-3)
#define SCALE           (5.0)
#define CG_RATE         (2.0)
#define VERBOSE         (1)
#define NORMALIZE       (1)
#define WARM_START      (0)

#endif
